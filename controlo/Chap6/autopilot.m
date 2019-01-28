function y = autopilot(uu,P)

%
% autopilot for mavsim
% 
% Modification History:
%   2/11/2010 - RWB
%   5/14/2010 - RWB
%   9/30/2014 - RWB
%   

    % process inputs
    NN = 0;
%   pn       = uu(1+NN);  % inertial North position
%   pe       = uu(2+NN);  % inertial East position
    h        = uu(3+NN);  % altitude
    Va       = uu(4+NN);  % airspeed
%   alpha    = uu(5+NN);  % angle of attack
    beta     = uu(6+NN);  % side slip angle
    phi      = uu(7+NN);  % roll angle
    theta    = uu(8+NN);  % pitch angle
    chi      = uu(9+NN);  % course angle
    p        = uu(10+NN); % body frame roll rate
    q        = uu(11+NN); % body frame pitch rate
    r        = uu(12+NN); % body frame yaw rate
%   Vg       = uu(13+NN); % ground speed
%   wn       = uu(14+NN); % wind North
%   we       = uu(15+NN); % wind East
%   psi      = uu(16+NN); % heading
%   bx       = uu(17+NN); % x-gyro bias
%   by       = uu(18+NN); % y-gyro bias
%   bz       = uu(19+NN); % z-gyro bias
    
    NN = NN+19;
    
    Va_c     = uu(1+NN);  % commanded airspeed (m/s)
    h_c      = uu(2+NN);  % commanded altitude (m)
    chi_c    = uu(3+NN);  % commanded course (rad)
    
    NN = NN+3;
    
    t        = uu(1+NN);   % time
   
    [delta, x_command] = autopilot_uavbook(Va_c,h_c,chi_c,Va,h,chi,phi,theta, beta,p,q,r,t,P);
    
    y = [delta; x_command];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% autopilot_uavbook
%   - autopilot defined in the uavbook
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [delta, x_command] = autopilot_uavbook(Va_c,h_c,chi_c,Va,h,chi,phi,theta,beta,p,q,r,t,P)
   
    %----------------------------------------------------------
    % lateral autopilot
    if t==0
        phi_c   = course_hold(chi_c, chi, 1, P.G.k_p_course, P.G.k_i_course, -pi/4, pi/4, P.Ts);
        %delta_r = sideslip_hold(beta, 1,  P.G.k_p_sideslip, P.G.k_i_sideslip, -P.G.delta_r_max, P.G.delta_r_max, P.Ts);
        delta_r = 0;
        delta_a = roll_hold(phi_c, phi, 1, p, P.G.k_p_roll, P.G.k_i_roll, P.G.k_d_roll, -P.G.delta_a_max, P.G.delta_a_max, P.Ts);
    else
        phi_c   = course_hold(chi_c, chi, 0, P.G.k_p_course ,P.G.k_i_course, -pi/4, pi/4, P.Ts);
        %delta_r = sideslip_hold(beta, 0,  P.G.k_p_sideslip, P.G.k_i_sideslip, -P.G.delta_r_max, P.G.delta_r_max, P.Ts);
        delta_r = 0;
        delta_a = roll_hold(phi_c, phi, 0, p, P.G.k_p_roll, P.G.k_i_roll, P.G.k_d_roll, -P.G.delta_a_max, P.G.delta_a_max, P.Ts);
    end
    
    
    
    %----------------------------------------------------------
    % longitudinal autopilot
    
    % define persistent variable for state of altitude state machine
    persistent altitude_state;
    flag = 0;
    % initialize persistent variable
    

    if h<=P.altitude_take_off_zone
        if altitude_state ~= 1
           flag = 1; 
        end
        altitude_state = 1;
    elseif h<=h_c-P.altitude_hold_zone
        if altitude_state ~= 2
           flag = 1; 
        end
        altitude_state = 2;
    elseif h>=h_c+P.altitude_hold_zone
        if altitude_state ~= 3
           flag = 1; 
        end
        altitude_state = 3;
    else
        if altitude_state ~= 4
           flag = 1; 
        end
        altitude_state = 4;
    end
 
    
    % implement state machine
    switch altitude_state
        case 1  % in take-off zone 
            delta_t = 0.5;
            theta_c = P.theta_c_climb;
            
        case 2  % climb zone
            delta_t = 0.5;
            theta_c = airspeed_pitch_hold(Va_c, Va, flag, P.G.k_p_pitch_airspeed, P.G.k_i_pitch_airspeed, -pi/4, pi/4, P.Ts);
           
        case 3 % descend zone
            delta_t = 0;
            theta_c = airspeed_pitch_hold(Va_c, Va, flag, P.G.k_p_pitch_airspeed, P.G.k_i_pitch_airspeed, -pi/4, pi/4, P.Ts);
            
        case 4 % altitude hold zone
            delta_t = airspeed_throtle_hold(Va_c, Va, P.u_trim(4), flag, P.G.k_p_throttle_airspeed, P.G.k_i_throttle_airspeed, 0 , 1, P.Ts); 
            theta_c = altitude_pitch_hold(h_c, h, flag, P.G.k_p_pitch_altitude, P.G.k_i_pitch_altitude, -pi/4, pi/4, P.Ts);            
    end
    
     delta_e = pitch_hold(theta_c, theta, flag, q, P.G.k_p_pitch, P.G.k_d_pitch, -P.G.delta_e_max, P.G.delta_e_max);

    %----------------------------------------------------------
    % create outputs
    
    % control outputs
    delta = [delta_e; delta_a; delta_r; delta_t];
    
    % commanded (desired) states
    x_command = [...
        0;...                    % pn
        0;...                    % pe
        h_c;...                  % h
        Va_c;...                 % Va
        0;...                    % alpha
        0;...                    % beta
        phi_c;...                % phi
        %theta_c*P.K_theta_DC;... % theta
        theta_c;
        chi_c;...                % chi
        0;...                    % p
        0;...                    % q
        0;...                    % r
        ];
            
    y = [delta; x_command];
 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autopilot functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function phi_c = course_hold(chi_c, chi, flag, kp, ki, lowLim, upLim, Ts)

    persistent p;
    persistent i;
   
    if flag == 1
       i = 0;
       p = 0;
    end
    
    error = chi_c - chi;
    i = i + (Ts/2)*(error + p);
    p = error;
    
    phi_c = sat(kp*p+ki*i, upLim, lowLim);
    
    if ki~=0
        u_unsat = kp*p + ki*i;
        i = i + Ts/ki * (phi_c - u_unsat);
    end
end

function delta_r = sideslip_hold(beta, flag, kp, ki, lowLim, upLim, Ts)
    
    persistent p;
    persistent i;
    
    if flag == 1
       i = 0;
       p = 0;
    end

    
    error = -beta;
    i = i + (Ts/2)*(error + p);
    p = error;
    
    delta_r = sat(-kp*p-ki*i, upLim, lowLim);
    
    if ki~=0
        u_unsat = -kp*p - ki*i;
        i = i + Ts/ki *(-u_unsat);
    end
end


function u = roll_hold(y_c, y, flag, p_rate, kp, ki, kd, lowLim, upLim, Ts)
    
    persistent p;
    persistent i;

    if flag == 1
       i = 0;
       p = 0;
    end
    
    error = y_c - y;
    i = i + (Ts/2)*(error + p);
    p= error;
    
    u = sat(kp*p+ki*i-kd*p_rate, upLim, lowLim);
    
    if ki~=0
        u_unsat = kp*p + ki*i - kd*p_rate;
        i = i + Ts/ki * (u - u_unsat);
    end
end

function u = pitch_hold(y_c, y, flag, q_rate, kp, kd, lowLim, upLim)
    
    persistent p;

    if flag == 1
       p = 0;
    end
    
    error = y_c - y;
    p= error;
    u = sat(kp*p-kd*q_rate, upLim, lowLim);
end


function u = airspeed_pitch_hold(y_c, y, flag, kp, ki, lowLim, upLim, Ts)

    persistent p;
    persistent i;
   
    if flag == 1
       i = 0;
       p = 0;
    end
    
    error = y_c - y;
    i = i + (Ts/2)*(error + p);
    p = error;
    
    u = sat(+kp*p+ki*i, upLim, lowLim);
    
    if ki~=0
        u_unsat = kp*p + ki*i;
        i = i + Ts/ki *(u-u_unsat);
    end
end

function u = airspeed_throtle_hold(y_c, y, trim, flag, kp, ki, lowLim, upLim, Ts)

    persistent p;
    persistent i;
   
    if flag == 1
       i = 0;
       p = 0;
    end
    
    error = y_c - y;
    i = i + (Ts/2)*(error + p);
    p = error;
    
    u = sat(trim+kp*p+ki*i, upLim, lowLim);
    
    if ki~=0
        u_unsat = trim + kp*p + ki*i;
        i = i + Ts/ki *(u-u_unsat);
    end
end

function u = altitude_pitch_hold(y_c, y, flag, kp, ki, lowLim, upLim, Ts)

    persistent p;
    persistent i;
   
    if flag == 1
       i = 0;
       p = 0;
    end
    
    error = y_c - y;
    i = i + (Ts/2)*(error + p);
    p = error;
    
    u = sat(+kp*p+ki*i, upLim, lowLim);
    
    if ki~=0
        u_unsat = kp*p + ki*i;
        i = i + Ts/ki *(u-u_unsat);
    end
end



  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sat
%   - saturation function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [u,C] = pidloop(y_c, y, flag, kp, ki, kd, lowLim, upLim, Ts, C)
%     
%     tau = Ts/2;
%     
%     if flag == 1
%        C.i = 0;
%        C.d = 0;
%        C.p = 0;
%     end
%     
%     error = y_c - y;
%     C.i = C.i + (Ts/2)*(error + C.e);
%     C.d = (2*tau-Ts)/(2*tau+Ts)*C.d+ 2/(2*tau+Ts)*(error - C.e);
%     C.p= error;
%     
%     u = sat(kp*C.p+ki*C.i+kd*C.d, upLim, lowLim);
%     
%     if ki~=0
%         u_unsat = kp*C.e + ki*C.i + kd*C.d;
%         C.i = C.i + Ts/ki * (u - u_unsat);
%     end
% 
% end

function out = sat(in, up_limit, low_limit)
  if in > up_limit
      out = up_limit;
  elseif in < low_limit
      out = low_limit;
  else
      out = in;
  end
end
  
 