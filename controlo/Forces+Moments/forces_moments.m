% forces_moments.m
%   Computes the forces and moments acting on the airframe. 
%
%   Output is
%       F     - forces
%       M     - moments
%       Va    - airspeed
%       alpha - angle of attack
%       beta  - sideslip angle
%       wind  - wind vector in the inertial frame
%

function out = forces_moments(x, delta, wind, P)

    % relabel the inputs
    pn      = x(1);
    pe      = x(2);
    pd      = x(3);
    u       = x(4);
    v       = x(5);
    w       = x(6);
    phi     = x(7);
    theta   = x(8);
    psi     = x(9);
    p       = x(10);
    q       = x(11);
    r       = x(12);
    delta_e = delta(1);
    delta_a = delta(2);
    delta_r = delta(3);
    delta_t = delta(4);
    w_ns    = wind(1); % steady wind - North
    w_es    = wind(2); % steady wind - East
    w_ds    = wind(3); % steady wind - Down
%     u_wg    = wind(4); % gust along body x-axis
%     v_wg    = wind(5); % gust along body y-axis    
%     w_wg    = wind(6); % gust along body z-axis

    %No gusts
    u_wg = 0; v_wg = 0; w_wg = 0;
        
    %% Compute air data
            
    swind_vec = rotateFromInertialtoBody(phi,theta,psi,w_ns,w_es,w_ds);
    wind_vec = swind_vec + [u_wg,v_wg,w_wg];
    u_w = wind_vec(1); v_w = wind_vec(2); w_w = wind_vec(3);
    
    u_r = u - u_w;
    v_r = v - v_w;
    w_r = w - w_w;
    
    % compute wind data in NED
    inertial_wind_vec = rotateFromBodytoInertial(phi,theta,psi,u_w,v_w,w_w);
    w_n = inertial_wind_vec(1); w_e = inertial_wind_vec(2);
    w_d = inertial_wind_vec(3);
    
    Va = sqrt(u_r^2+v_r^2+w_r^2);
    
    if abs(u_r) > 1e-5
        alpha = atan2(w_r,u_r);
    else
        alpha = 0;
    end
    
    if Va > 1e-5
        beta = asin(v_r/Va);
    else
        beta = 0;
    end

    %% Compute external forces and torques on aircraft
    
    Force = zeros(3,1);
    Torque = zeros(3,1);
    
    if Va > 1e-5
        Force = getFAer(Va,alpha,q,delta_e,beta,p,r,delta_a,delta_r,P);
        Torque = getTorques(Va,alpha,q,delta_e,beta,p,r,delta_a,delta_r,P);
    end
    
    % Add thrust and torque generated by the propeller
    F_prop = 0.5*P.rho*P.Sprop*P.Cprop*((P.k_motor*delta_t)^2-Va^2);
    Force = Force + [F_prop;0;0];
    Torque = Torque + [-P.k_tp*(P.k_omega*delta_t)^2;0;0];

    % Gravity
    Fg_body = rotateFromInertialtoBody(phi,theta,psi,0,0,P.mass*P.gravity);
    Force = Force + Fg_body';
    
    out = [Force',Torque', Va, alpha, beta, w_n, w_e, w_d];
end

