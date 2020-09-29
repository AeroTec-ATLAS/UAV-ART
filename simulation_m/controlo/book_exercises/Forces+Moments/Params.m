P = load('aerosonde_data.mat');

P.gravity = 9.8;
P.rho = 1.2682;

%% Steady Wind at the inertial frame
P.wind_n = 0;
P.wind_e = 0;
P.wind_d = 0;

%% Gust generation - Check Table 4.1 from book (Dryden gust model params)
P.sigma_u = 1.06;
P.sigma_v = 1.06;
P.sigma_w = 0.7;
P.Va0 = 10;
P.L_u = 200;
P.L_v = 200;
P.L_w = 50;
P.Ts = 0.1; %Zero-hold sample time

%% Initial Conditions (inertial position, ground speesvmsvnd, attitude)
P.pn0    =   -20; % initial North position
P.pe0    =   0; % initial East position
P.pd0    =   -30; % initial Down position (negative altitude)
P.u0     =   0; % initial velocity along body x-axis
P.v0     =   0; % initial velocity along body y-axis
P.w0     =   0; % initial velocity along body z-axis
P.phi0   =   0; % initial roll angle
P.theta0 =   0; % initial pitch angle
P.psi0   =   0; % initial yaw angle
P.p0     =   0; % initial body frame roll rate
P.q0     =   0; % initial body frame pitch rate
P.r0     =   0; % initial body frame yaw rate

