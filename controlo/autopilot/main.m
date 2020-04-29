
% UAV-ART (UAV Alameda Research Team)
% Project UAV-P1
% Aerotéc - Núcleo de Alunos de Engenharia Aeroespacial do Técnico
% Instituto Superior Técnico
% Started in October 2018
% 
% Authors: J. Pinto, L. Pedroso
% 
% In order to change the parameters of the aircraft or compute a new trim
% condition in the trim folder there is the script named **params** 
% to do so.
% Should one want to change the controller gains, the getGains function,
% located in the same folder, is to be edited.
% 
% Ensure you have installed the R2018a Simulink version or a newer one.
% 
% Check R. W. Beard & T. W. McLain, Small Unmanned Aircraft (2012) for more
% details on the autopilot arquitecture.
% Go to http://uavbook.byu.edu/doku.php?id=start to obtain the files
% necessary to solve the exercises suggested in the book and other 
% resources.

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

T = 30; % simulation time in seconds
t = 0:P.Ts:T;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define control references for the autopilot
% Check chapter VI of the aformentioned book (Successive Loop Closure)
% 
% Controller arquitecture summary:
% -> Lateral Autopilot - control the course angle (chi) using roll (phi); 
% the sideslip angle (beta) is commanded to 0.
% 
% -> Longitudinal Autopilot - regulate airspeed (Va) and altitude (h) using
% throttle (delta_t) and pitch (theta).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_ref = 200*ones(length(t),1); % height (m)
% h_ref(2001:4001) = 50*ones(2001,1);
% chi_ref = 0*pi/180*ones(length(t),1) + 0.1*randn(length(t),1); % course angle (rad)
chi_ref = 0*ones(length(t),1);
% chi_ref(3001:5001) = 170*pi/180*ones(2001,1);
Va_ref = P.Va0*ones(length(t),1); % airspeed (m/s)

reference = [t' Va_ref h_ref chi_ref];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sim('autopilot_sim.slx',T);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pos = state.signals.values(:,1:3); % [pn pe pd]
v   = state.signals.values(:,4:6); % [u v w]
att = state.signals.values(:,7:9); % [phi theta psi]
ang_v = state.signals.values(:,10:12); % [p q r]

roll_ref = x_command.signals.values(:,1);
theta_ref = x_command.signals.values(:,2);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drawAircraft(pos,att,V,F,facecolors,2e-3)
% morePlots


