
% UAV-ART (UAV Alameda Research Team)
% Project UAV-P1
% Aerotéc - Núcleo de Alunos de Engenharia Aeroespacial do Tï¿½cnico
% Instituto Superior Técnico
% Started in October 2018
%
% Authors: J. Pinto, L. Pedroso

clear
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load structure with the physical parameters of the aircraft, its
% aerodynamic coefficients, initial conditions, wind parameters, controller
% gains and other necessary constants.
load trim/params

% Load aircraft for 3-D animation
load anim/aircraft
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('anim','util','trim')

T = 60; % simulation time in seconds
t = 0:P.Ts:T;



% gains:
% Airspeed controller

k_VP = 0.5; %arbitrary value
k_VI = 0.8; %arbitrary value


Va_ref = P.Va0*ones(length(t),1); % airspeed (m/s)


reference = [t' Va_ref];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sim('autopilot_total.slx',T);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pos = state.signals.values(:,1:3); % [pn pe pd]
v   = state.signals.values(:,4:6); % [u v w]
att = state.signals.values(:,7:9); % [phi theta psi]
ang_v = state.signals.values(:,10:12); % [p q r]

% roll_ref = x_command.signals.values(:,1);
% theta_ref = x_command.signals.values(:,2);

Va = airdata.signals.values(:,1);
alpha = airdata.signals.values(:,2);
beta = airdata.signals.values(:,3);
wind_data = airdata.signals.values(:,4:6); % [wn we wd]

chi = atan2(Va.*sin(att(:,3))+wind_data(:,2), ...
                                    Va.*cos(att(:,3))+wind_data(:,1));
delta = delta.signals.values; % [delta_e delta_a delta_r delta_t]

% Aerodynamic Forces and Moments (expressed in the body frame)
F_aero = aero.signals.values(:,1:3); % [Lift Drag Fy]
T_aero = aero.signals.values(:,4:6); % [L M N]

% Total Forces and Moments (expressed in the body frame)
F_body = FM.signals.values(:,1:3); % [fx fy fz]
T_body = FM.signals.values(:,4:6); % [taux tauy tauz], tauy = M, tauz = N

% Total Acceleration (expressed in the body frame)
accel(:,1) = 1/P.mass * F_body(:,1) + P.gravity*sin(att(:,2)); % ax
accel(:,2) = 1/P.mass * F_body(:,2) - P.gravity*cos(att(:,2)).*sin(att(:,1)); %ay
accel(:,3) = 1/P.mass * F_body(:,3) - P.gravity*cos(att(:,2)).*cos(att(:,1)); %az

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawAircraft(pos,att,V,F,facecolors,2e-3)
morePlots
% logTXT
