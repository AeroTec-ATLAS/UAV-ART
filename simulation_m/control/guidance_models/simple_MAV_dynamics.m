% UAV-ART (UAV Alameda Research Team)
% Project UAV-P1
% Aerotéc - Núcleo de Alunos de Engenharia Aeroespacial do Técnico
% Instituto Superior Técnico
% Started in October 2018
% 
%
% % simple_MAV_dynamics
%  - reduced-order Simulink model that can be used to test and debug 
%    the guidance algorithm discussed in later chapters
%
%
% states: pn, pe, chi, h, Va, chi_dot, h_dot
% input: chi_c, h_c, Va_c
% output: pn, pe, chi, h, Va
% 


function [sys,x0,str,ts,simStateCompliance] = simple_MAV_dynamics(t,x,u,flag,P)



switch flag

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0
    [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes(P);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1
    sys = mdlDerivatives(t,x,u,P);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2
    sys = mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3
    sys = mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4
    sys = mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9
    sys = mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(P)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 7;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%

x0  = [...
    P.pn0;...
    P.pe0;...
    atan2(P.Va0*sin(P.psi0)+P.wind_e, P.Va0*cos(P.psi0)+P.wind_n);... %chi0
    -P.pd0;... %h0
    P.Va0;...
    0;... %chi_dot0
    0;... %h_dot0
    ];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,uu,P)

    pn        = x(1);  % inertial North position
    pe        = x(2);  % inertial East position
    chi       = x(3);  
    h         = x(4);  
    Va        = x(5);  
    chi_dot   = x(6);  
    h_dot     = x(7);  
    chi_c     = uu(1); 
    h_c       = uu(2); 
    Va_c      = uu(3); 
    
    %********** COEFFICIENTS *********%
    b_chidot  = 5;   
    b_chi     = 1.1; 
    b_hdot = 0.4;  
    b_h    = 0.05; 
    b_va      = 0.09;
    %*********************************%
    
    psi= chi - asin((1/Va)*[P.wind_n P.wind_e]*[-sin(chi); cos(chi)]); 
    pn_dot = Va*cos(psi) + P.wind_n;
    pe_dot = Va*sin(psi) + P.wind_e;

    % derivatives calculation
    [chi_c_dot] = derivada_chi(t, chi_c);
    % [h_c_dot] = derivada_h(t, h_c);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    x1 = h;
    x2 = h_dot;
    x3 = chi;
    x4 = chi_dot;
    
    % x2_dot = b_hdot*(h_c_dot - x2) + b_h*(h_c - x1);
    x2_dot = - b_hdot*x2 + b_h*(h_c - x1);
    x4_dot = b_chidot*(chi_c_dot - x4) + b_chi*(chi_c - x3);
    Va_dot = b_va*(Va_c - Va);
    %%%%%%%%%%%%%%%%%%%%%%%%
    
sys = [pn_dot; pe_dot; chi_dot; h_dot; Va_dot; x4_dot; x2_dot];
% end mdlDerivatives


%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)

sys = [x(1); x(2); x(3); x(4); x(5)];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

%end mdlTerminate



