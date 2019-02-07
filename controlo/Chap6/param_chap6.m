P.gravity = 9.8;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Params for Aersonade UAV
%physical parameters of airframe

P.mass = 25;
P.Jx   = 0.8244;
P.Jy   = 1.135;
P.Jz   = 1.759;
P.Jxz  = 0.1204;

P.g = P.Jx*P.Jz - P.Jxz^2;
P.g1 = P.Jxz*(P.Jx - P.Jy + P.Jz)/P.g;
P.g2 = (P.Jz*(P.Jz - P.Jy) + P.Jxz^2)/P.g;
P.g3 = P.Jz/P.g;
P.g4 = P.Jxz/P.g;
P.g5 = (P.Jz - P.Jx)/P.Jy;
P.g6 = P.Jxz/P.Jy;
P.g7 = ((P.Jx - P.Jy)*P.Jx + P.Jxz^2)/P.g;
P.g8 = P.Jx/P.g;

% aerodynamic coefficients
P.S_wing        = 0.55;
P.b             = 2.8956;
P.c             = 0.18994;
P.S_prop        = 0.2027;
P.rho           = 1.2682;
P.k_motor       = 80;
P.k_T_P         = 0;
P.k_Omega       = 0;
P.e             = 0.9;

P.C_L_0         = 0.28;
P.C_L_alpha     = 3.45;
P.C_L_q         = 0.0;
P.C_L_delta_e   = -0.36;
P.C_D_0         = 0.03;
P.C_D_alpha     = 0.30;
P.C_D_p         = 0.0437;
P.C_D_q         = 0.0;
P.C_D_delta_e   = 0.0;
P.C_m_0         = -0.02338;
P.C_m_alpha     = -0.38;
P.C_m_q         = -3.6;
P.C_m_delta_e   = -0.5;
P.C_Y_0         = 0.0;
P.C_Y_beta      = -0.98;
P.C_Y_p         = 0.0;
P.C_Y_r         = 0.0;
P.C_Y_delta_a   = 0.0;
P.C_Y_delta_r   = -0.17;
P.C_ell_0       = 0.0;
P.C_ell_beta    = -0.12;
P.C_ell_p       = -0.26;
P.C_ell_r       = 0.14;
P.C_ell_delta_a = 0.08;
P.C_ell_delta_r = 0.105;
P.C_n_0         = 0.0;
P.C_n_beta      = 0.25;
P.C_n_p         = 0.022;
P.C_n_r         = -0.35;
P.C_n_delta_a   = 0.06;
P.C_n_delta_r   = -0.032;
P.C_prop        = 1.0;
P.M             = 50;
P.epsilon       = 0.1592;
P.alpha0        = 0.4712;

% combination of coefficients
P.C_p_0 = P.g3*P.C_ell_0 + P.g4*P.C_n_0;
P.C_p_beta = P.g3*P.C_ell_beta + P.g4*P.C_n_beta;
P.C_p_p = P.g3*P.C_ell_p + P.g4*P.C_n_p;
P.C_p_delta_a = P.g3*P.C_ell_delta_a + P.g4*P.C_n_delta_a;

% wind parameters
P.wind_n = 0;
P.wind_e = 0;
P.wind_d = 0;
P.L_u = 200;
P.L_v = 200;
P.L_w = 50;
P.sigma_u = 1.06; 
P.sigma_v = 1.06;
P.sigma_w = .7;

% P.sigma_u = 0; 
% P.sigma_v = 0;
% P.sigma_w = 0;

% compute trim conditions using 'mavsim_chap5_trim.slx'
% initial airspeed
P.Va0 = 35;
gamma = 0;  % desired flight path angle (radians)
R     = inf;         % desired radius (m) - use (+) for right handed orbit, 

% autopilot sample rate
P.Ts = 0.01;

% first cut at initial conditions
P.pn0    = 0;  % initial North position
P.pe0    = 0;  % initial East position
P.pd0    = 0;  % initial Down position (negative altitude)
P.u0     = P.Va0; % initial velocity along body x-axis
P.v0     = 0;  % initial velocity along body y-axis
P.w0     = 0;  % initial velocity along body z-axis
P.phi0   = 0;  % initial roll angle
P.theta0 = pi/6;  % initial pitch angle
P.psi0   = 0;  % initial yaw angle
P.p0     = 0;  % initial body frame roll rate
P.q0     = 0;  % initial body frame pitch rate
P.r0     = 0;  % initial body frame yaw rate

                    %                          (-) for left handed orbit                   
% run trim commands
[x_trim, u_trim]=compute_trim('mavsim_trim',P.Va0,gamma,R);

P.theta_c_climb = pi/6;
[x_trim_take_off, u_trim_take_off] = compute_trim('mavsim_trim',P.Va0,P.theta_c_climb,R)

P.throttle_take_off = u_trim_take_off(4);

P.u_trim = u_trim;
P.x_trim = x_trim;

% set initial conditions to trim conditions
% initial conditions
P.pn0    = 0;  % initial North position
P.pe0    = 0;  % initial East position
P.pd0    = 0;  % initial Down position (negative altitude)
P.u0     = x_trim(4);  % initial velocity along body x-axis
P.v0     = x_trim(5);  % initial velocity along body y-axis
P.w0     = x_trim(6);  % initial velocity along body z-axis
P.phi0   = x_trim(7);  % initial roll angle
P.theta0 = x_trim(8);  % initial pitch angle
P.psi0   = x_trim(9);  % initial yaw angle
P.p0     = x_trim(10);  % initial body frame roll rate
P.q0     = x_trim(11);  % initial body frame pitch rate
P.r0     = x_trim(12);  % initial body frame yaw rate

% compute different transfer functions
[T_phi_delta_a,T_p_delta_a,T_chi_phi,T_theta_delta_e, T_theta_dot_delta_e,T_h_theta,T_h_Va,T_Va_delta_t,T_Va_theta,T_Va,T_v_delta_r,G]...
    = compute_tf_model(x_trim,u_trim,P);

% linearize the equations of motion around trim conditions
% Acho que o Tiago desistiu
%[A_lon, B_lon, A_lat, B_lat] = compute_ss_model('mavsim_trim',x_trim,u_trim)

P = getGains(P,G);

% AUTOPILOT CONST

P.altitude_take_off_zone = 40;
P.altitude_hold_zone = 25;



%DEBUGGING




