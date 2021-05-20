
% UAV-ART (UAV Alameda Research Team)
% Project UAV-P1
% Aerotec - Núcleo de Alunos de Engenharia Aeroespacial do Técnico
% Instituto Superior Técnico
% Started in August 2020
% 
% Authors: 
% 
% Ensure you have installed the R2018a Simulink version or a newer one.
% 
% Check R. W. Beard & T. W. McLain, Small Unmanned Aircraft (2012) for more
% details on the path follower architecture.
% Go to http://uavbook.byu.edu/doku.php?id=start to obtain the files
% necessary to solve the exercises suggested in the book and other 
% resources.

% -------------------------------------------------------------------------

% Pre-Execution
% Clean workspace to ensure an indepent execution of the file
clear
close all

% Load structure with the physical parameters of the aircraft, its
% aerodynamic coefficients, initial conditions, wind parameters, controller
% gains and other necessary constants
load ../autopilot/trim/params

% Allows the simulink diagram to access files in the given directories
addpath('../autopilot', '../autopilot/util','../pathFollower')


% -------------------------------------------------------------------------
% Configurations
% To change initial conditions, read and configure the script
% '../autopilot/trim/params.m' before running this script
% You can open it by entering 'open ../autopilot/trim/params'

% Simulation configurations
settings.simTime = 300;
% 0 if you do not want and 1 if you do want
settings.wantToDrawAircraft = 1;
settings.wantToCreateGraphics = 1; 
settings.folder = "results/";
% -------------------------------------------------------------------------

% Simulation
PLAN.Va0 = P.Va0;
PLAN.size_waypoint_array = 5;
PLAN.R_min = 250;
% Initial altitude
P.pd0 = -100;
% Run simulation
out = sim('PathManager.slx',settings.simTime);
set_param('PathManager','AlgebraicLoopSolver','LineSearch')

% Output assignment
% Time
t = out.tout;
 
% Commands
command.Va_c = out.commandsWs(:,1);
command.h_c = out.commandsWs(:,2);
command.chi_c = out.commandsWs(:,3);
command.phi_ff = out.commandsWs(:,4);

% States
state.pos = out.stateWs(:,1:3);
state.v = out.stateWs(:,4:6);
state.att = out.stateWs(:,7:9);
state.ang_v = out.stateWs(:,10:12);

% Delta
dd.e = out.deltaWs(:,1);
dd.a = out.deltaWs(:,2);
dd.r = out.deltaWs(:,3);
dd.t = out.deltaWs(:,4);

% Forces and moments
F = out.FMWs(:,1:3);
M = out.FMWs(:,4:6);

% Aerodynamic forces and moments
aeroF = out.aeroFMWs(:,1:3);
aeroM = out.aeroFMWs(:,4:6);

% Airdata
air.Va = out.airdataWs(:,1);
air.aa = out.airdataWs(:,2);
air.bb = out.airdataWs(:,3);
air.v_w = out.airdataWs(:,4:6);

% Erase output timeseries
clear out

% -------------------------------------------------------------------------

% Results
% Animation
if settings.wantToDrawAircraft
    drawAircraftPathFollower(t,state.pos,state.att,path,1e-4,0)
end

% Graphics
if settings.wantToCreateGraphics
    addpath('graphicsFunctions')
    
    mkdir(settings.folder)
    
    positionGraphics(state.pos,path,settings.folder)
    deltaGraphics(t,dd,settings.folder)
    aerodynamicAnglesGraphics(t,air.aa,air.bb,settings.folder)
    attitudeGraphics(t,state.att,settings.folder)
    speedsGraphics(t,air.Va,air.v_w,settings.folder)
    angularVelocitiesGraphics(t,state.ang_v,settings.folder)
end