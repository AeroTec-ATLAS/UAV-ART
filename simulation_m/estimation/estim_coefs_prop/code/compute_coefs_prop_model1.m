clc
clear
close all

%% escolher ficheiros
propStr = '10x5';
supplyStr = 'bat3s';
vStrs = ["6","10","15","20"];
Va_total = [];
DeltaT_total = [];
T_total = [];

D_prop = str2double(propStr(1:2));  % diameter of propeller in inches
D_prop = 0.0254*D_prop;             % conversion to meters

for i=1:length(vStrs)
    load("Ficheiros_processados/ProcessedData_test_prop"+propStr+"_"+supplyStr+"_v"+vStrs(i))
    Va_total = [Va_total; Va'];
    DeltaT_total = [DeltaT_total; DeltaT'];
    T_total = [T_total; T'];
end

%% variaveis
rho = 1.225; 
C_prop = 1;
S_prop = pi*(D_prop/2)^2;

%% modelo:
% T = 0.5*rho*S_prop*C_prop*((k_motor*delta_t)^2 - Va^2)

Y = sqrt(T_total./(0.5*rho*S_prop*C_prop) + Va_total.^2);
Phi = DeltaT_total;

k_motor = NRLS(Y,Phi);


function Coef = NRLS(Y,Phi)
Coef = (Phi'*Phi)^(-1) * Phi'*Y;
end