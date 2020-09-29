
S = load('aerosonde_data.mat');

P.gravity = 9.8;
   
%physical parameters of airframe
P.mass = S.m;
P.Jx   = S.Jx;
P.Jy   = S.Jy;
P.Jz   = S.Jz;
P.Jxz  = S.Jxz;

% initial conditions
P.pn0    =   0; % initial North position
P.pe0    =   0; % initial East position
P.pd0    =   0; % initial Down position (negative altitude)
P.u0     =   0; % initial velocity along body x-axis
P.v0     =   0; % initial velocity along body y-axis
P.w0     =   0; % initial velocity along body z-axis
P.phi0   =   0; % initial roll angle
P.theta0 =   0; % initial pitch angle
P.psi0   =   0; % initial yaw angle
P.p0     =   0; % initial body frame roll rate
P.q0     =   0; % initial body frame pitch rate
P.r0     =   0; % initial body frame yaw rate

