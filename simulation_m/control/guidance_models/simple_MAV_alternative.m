function [sys,x0,str,ts,simStateCompliance] = simple_MAV_alternative(t,x,u,flag,P)

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
sizes.NumOutputs     = 6;
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
    P.psi0;...
    -P.pd0;...
    P.Va0;...
    P.phi0;...
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

    pn       = x(1);
    pe       = x(2);
    psi      = x(3);
    h        = x(4);
    Va       = x(5);
    phi      = x(6);
    h_dot    = x(7);
    h_c      = uu(1);
    Va_c     = uu(2);
    phi_c    = uu(3);
    
    %********** COEFFICIENTS *********%   
    b_hdot = 0.4;
    b_h    = 0.05;    
    b_va   = 0.09; 
    b_phi  = 0.2;
    %*********************************%
        
    pn_dot  = Va*cos(psi) + P.wind_n;
    pe_dot  = Va*sin(psi) + P.wind_e;
    psi_dot = (P.gravity/Va) * tan(phi);

    % derivative calculation
    % [h_c_dot]= derivada_h(t, h_c);  
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    x1 = h;
    x2 = h_dot;
    
    x1_dot = x2;
    % x2_dot = b_hdot*(h_c_dot - x2) + b_h*(h_c - x1);
    x2_dot = - b_hdot*x2 + b_h*(h_c - x1);
    Va_dot  = b_va*(Va_c - Va);
    phi_dot = b_phi*(phi_c - phi);
    %%%%%%%%%%%%%%%%%%%%%%%%
    
sys = [pn_dot; pe_dot; psi_dot; x1_dot; Va_dot; phi_dot; x2_dot];
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

sys = [x(1); x(2); x(3); x(4); x(5);x(6)];

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


