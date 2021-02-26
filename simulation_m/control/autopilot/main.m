
% UAV-ART (UAV Alameda Research Team)
% Project UAV-P1
% Aerot�c - N�cleo de Alunos de Engenharia Aeroespacial do T�cnico
% Instituto Superior T�cnico
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

T = 240; % simulation time in seconds
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

% h_ref = 200 + 10*(t').*ones(length(t),1); % height (m)

% for i = 1:length(t) %Os primeiros 2 elementos ser�o nulos
%
%     h_ref(i)= 0.5*t(i);
% end

% h_ref = 200*ones(length(t),1);

h_ref(1:2000) = 50*ones(2000,1);
h_ref(2001:4000) = 60*ones(2000,1);
h_ref(4001:6000) = 50*ones(2000,1);
for i = 6001:9000
    h_ref(i) = 50 + (70 - 50)/(9000 - 6000)*(i - 6000);
end
for i = 9001:12000
    h_ref(i) = 70 + (50 - 70)/(12000 - 9000)*(i - 9000);
end
h_ref(12001:13000) = 50*ones(1000,1);
h_ref(13001:14000) = 40*ones(1000,1);
h_ref(14001:15000) = 50*ones(1000,1);
h_ref(15001:16000) = 40*ones(1000,1);
h_ref(16001:18000) = 50*ones(2000,1);
h_ref(18001:19000) = 60*ones(1000,1);
h_ref(19001:20000) = 50*ones(1000,1);
h_ref(20001:21000) = 60*ones(1000,1);
h_ref(21001:22000) = 50*ones(1000,1);
h_ref(22001:24001) = 50*ones(2001,1);
h_ref = h_ref';


% chi_ref = 0*pi/180*ones(length(t),1) + 0.1*randn(length(t),1); % course angle (rad)

chi_ref(1:1000) = 20*pi/180*ones(1000,1);
chi_ref(1001:2000) = 0*ones(1000,1);
chi_ref(2001:4000) = -20*pi/180*ones(2000,1);
chi_ref(4001:5000) = 0*ones(1000,1);
for i = 5001:9000
    chi_ref(i) = pi/180*(0 + (270 - 0)/(9000 - 5000)*(i - 5000));
end
for i = 9001:13000
    chi_ref(i) = pi/180*(270 + (0 - 270)/(13000 - 9000)*(i - 9000));
end
for i = 13001:17000
    chi_ref(i) = pi/180*(0 + (270 - 0)/(17000 - 9000)*(i - 9000));
end
for i = 17001:21000
    chi_ref(i) = pi/180*(270 + (0 - 270)/(21000 - 17000)*(i - 17000));
end
chi_ref(21001:24001) = 0*ones(3001,1);

chi_ref = chi_ref';

% Va_ref = P.Va0*ones(length(t),1); % airspeed (m/s)
Va_ref = 30*ones(length(t),1);

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

% Total Acceleration (expressed in the body frame)
accel(:,1) = 1/P.mass * F_body(:,1) + P.gravity*sin(att(:,2)); % ax
accel(:,2) = 1/P.mass * F_body(:,2) - P.gravity*cos(att(:,2)).*sin(att(:,1)); %ay
accel(:,3) = 1/P.mass * F_body(:,3) - P.gravity*cos(att(:,2)).*cos(att(:,1)); %az

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%drawAircraft(pos,att,V,F,facecolors,2e-3)
% morePlots

logTXT_wAccel
