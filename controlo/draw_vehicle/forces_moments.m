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

function [F,M] = forces_moments(x,delta, wind,R_vb,P)
    
    %% Init output
    
    F = zeros(3,1);
    M = zeros(3,1);

    %% Relabel the inputs
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
    u_wg    = wind(4); % gust along body x-axis
    v_wg    = wind(5); % gust along body y-axis    
    w_wg    = wind(6); % gust along body z-axis
    
    % compute wind data in NED
    w_n = 0;
    w_e = 0;
    w_d = 0;
    
    %% Compute air data
    Va = sqrt(u^2+v^2+w^2);
    if(abs(u) > eps)
        alpha = atan2(w,u);
    else
        alpha = 0;
    end
    if (Va > eps)
        beta = asin(v/Va);
    else
        beta = 0;
    end
    %% Compute external forces and torques on aircraft
    
    if(Va > eps)
        F_lift = 0.5*P.rho*Va^2*P.S_wing*(P.C_L_0 + P.C_L_alpha*alpha + P.C_L_q*(P.c/(2*Va))*q + P.C_L_delta_e*delta_e);
        F_drag = 0.5*P.rho*Va^2*P.S_wing*(P.C_D_0 + P.C_D_alpha*alpha + P.C_D_q*(P.c/(2*Va))*q + P.C_D_delta_e*delta_e);
        F(2) = 0.5*P.rho*Va^2*P.S_wing*(P.C_Y_0 + P.C_Y_beta*beta + P.C_Y_p*(P.b/(2*Va))*p + P.C_Y_r*(P.b/(2*Va))*r + P.C_Y_delta_a*delta_a + P.C_Y_delta_r*delta_r);
    else
        F_lift = 0;
        F_drag = 0;
        F(2) = 0;
    end
    
    F_prop = 0.5*P.rho*P.S_prop*P.C_prop*((P.k_motor*delta_t)^2-Va^2);
    
    T_ld_xy = [cos(alpha)   -sin(alpha);...
               sin(alpha)   cos(alpha)]; 
    
    Faer = transpose(T_ld_xy*[-F_lift;-F_drag]+[F_prop; 0]);
    
    F(1) = Faer(1);
    F(3) = Faer(2);

    F = F + R_vb*[0; 0; P.m*P.g];
    
    if(Va > eps)
        M(1) = 0.5*P.rho*Va^2*P.S_wing*P.b*(P.C_ell_0 + P.C_ell_beta*beta + P.C_ell_p*(P.b/(2*Va))*p + P.C_ell_r*(P.b/(2*Va))*r + P.C_ell_delta_a*delta_a + P.C_ell_delta_r*delta_r) - P.k_T_P*(P.k_Omega*delta_t)^2;
        M(2) = 0.5*P.rho*Va^2*P.S_wing*P.c*(P.C_m_0 + P.C_m_alpha*alpha + P.C_m_q*(P.c/(2*Va))*q + P.C_m_delta_e*delta_e);  
        M(3) = 0.5*P.rho*Va^2*P.S_wing*P.b*(P.C_n_0 + P.C_n_beta*beta + P.C_n_p*(P.b/(2*Va))*p + P.C_n_r*(P.b/(2*Va))*r + P.C_n_delta_a*delta_a + P.C_n_delta_r*delta_r);
    end
end



