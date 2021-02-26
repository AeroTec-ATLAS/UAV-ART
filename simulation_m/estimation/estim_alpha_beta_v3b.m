% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - José Neves
%          - Pedro Martins
%          - Simão Caeiro
%          - João Moura

% AoA and sideslip angles estimation

% Aircraft parameters
mass    = 25;
rho     = 1.2682;
S_wing  = 0.55;
K = rho*S_wing/(2*mass);

% Sampling period
dt = 0.01;

% Other parameters
d1 = [1; 0; 0];
d2 = [0; 1; 0];
d3 = [0; 0; 1];
a_us = 1e-7;
a_vs = 1e-7; 
a_ws = 1e-10;
a_ut = 5e2;
a_vt = 5e2;
a_wt = 2e2;
a_CL0 = 1e-6;
a_CLalpha = 1e-10;
a_gamma = 1e-15;
R = diag([1 0.6]);
sigma_vv = [0.1 0; 0 0.1];

% Initial conditions
x0 = [0 0 0 0 0 0 0 1 1]';
P0 = diag([1e-2 1e-2 1e-4 1e-5 1e-5 1e-5 1e-5 1e-1 1e-8]);

% Variables allocation
x_predict = zeros(9, length(data));
P_predict = cell(length(data),1);
x_update = zeros(9, length(data));
P_update = cell(length(data),1);
y = zeros(2, length(data));
z = zeros(2, length(data));
output_func = zeros(2, length(data));
alpha = zeros(1,length(data));
beta = zeros(1,length(data));
S = cell(length(data),1);
K_gain = cell(length(data),1);

% First iteration

delta_vt = [0 0 0]';
x_predict(:,1) = x0 + [0; 0; 0; delta_vt; 0; 0; 0];


Rot = rotateFromInertialtoBody_R(data(1).phi, data(1).theta, data(1).psi);
vr_b = [data(1).u data(1).v data(1).w]' - Rot*x0(1:3);
Va = norm(vr_b);
Lu = data(1).h/(0.177+0.000823*data(1).h)^1.2;
Lv = Lu;
Lw = data(1).h;

df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);
dVa_dus = - Va^-1*(Rot*d1)'*vr_b;      
dVa_dvs = - Va^-1*(Rot*d2)'*vr_b;      
dVa_dws = - Va^-1*(Rot*d3)'*vr_b;      
df_dv_s = [dt*x0(4)/Lu*dVa_dus, dt*x0(4)/Lu*dVa_dvs, dt*x0(4)/Lu*dVa_dws;...
    dt*x0(5)/Lv*dVa_dus, dt*x0(5)/Lv*dVa_dvs, dt*x0(5)/Lv*dVa_dws;...
    dt*x0(6)/Lw*dVa_dus, dt*x0(6)/Lw*dVa_dvs, dt*x0(6)/Lw*dVa_dws];
Id = eye(3);
zero = zeros(3);
F = [Id zero zero; df_dv_s df_dv_t zero; zero zero Id];

Vwg = sqrt(data(1).vnorth^2 + data(1).veast^2 + data(1).vdown^2);
sigma_u = Vwg*0.1/(0.177+0.000823*data(1).h)^0.4;
sigma_v = sigma_u;
sigma_w = 0.1*Vwg;

Q = ([a_us a_vs a_ws a_ut*sigma_u*sqrt(2*dT*Va/Lu) ...
        a_vt*sigma_v*sqrt(2*dt*Va/Lv) a_wt*sigma_w*sqrt(2*dt*Va/Lw) ...     %Possivelmente existe erro no paper, na entrada 6 onde tem sigma_v poderá ser  sigma_w)
        a_CL0 a_CLalpha a_gamma])*dt^2;

P_predict{1,1} = F*P0*F' + Q;

alpha(1) = atan2(vr_b(3),vr_b(1));
beta(1) = atan2(vr_b(2),Va);

Lr = chol(sigma_vv,'lower');                                                     
vk  = Lr*randn(2,1);
z(:,1) = [data(1).fz; data(1).u] + vk;                  %nao sei se temos o az ou o fz
output_func(:,1) = [-K*Va^2*(x0(7)+x0(8)*alpha(1)); ...
    d1*Rot*(x0(1:3)+x0(4:6))+x0(end)*data(1).ur_m];
y(:,1) = z(:,1) - output_func(:,1);


dh1_dus = 2*K*(Rot*d1)'*vr_b*(x0(7) + x0(8)*alpha(1)) + (- Rot(3,1)*vr_b(1) + ...
    Rot(1,1)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
dh1_dvs = 2*K*(Rot*d2)'*vr_b*(x0(7) + x0(8)*alpha(1)) + (- Rot(3,2)*vr_b(1) + ...
    Rot(1,2)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
dh1_dws = 2*K*(Rot*d3)'*vr_b*(x0(7) + x0(8)*alpha(1)) + (- Rot(3,3)*vr_b(1) + ...
    Rot(1,3)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
dh1_dut = K*Va^2*x0(8)*(Rot(3,1)*vr_b(1) - Rot(1,1)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
dh1_dvt = K*Va^2*x0(8)*(Rot(3,2)*vr_b(1) - Rot(1,2)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
dh1_dwt = K*Va^2*x0(8)*(Rot(3,3)*vr_b(1) - Rot(1,3)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);

H = [dh1_dus dh1_dvs dh1_dws dh1_dut dh1_dvt dh1_dwt -K*Va^2 ...
    -K*Va^2*alpha(1) 0; d1'*Rot d1'*Rot 0 0 data(1).ur_m];

S{1,1} = H*P_predict{1,1}*H' + R;

K_gain{1,1} = P_predict{1,1}*H'\S{1,1};

x_update(:,1) = x_predict(:,1) + K_gain{1,1}*y(:,1);

P_update{1,1} = (eye(9) - K_gain{1,1}*H)*P_predict{1,1};


for i = 2:length(data)
    
    delta_vt = -x_update(4:6,i-1)*dt*[Va/Lu Va/Lv Va/Lw];
    x_predict(:,i) = x_update(:,i-1) + [0; 0; 0; delta_vt; 0; 0; 0];
    
    Rot = rotateFromInertialtoBody_R(data(i).phi, data(i).theta, data(i).psi);
    vr_b = [data(i).u data(i).v data(i).w]' - Rot_init*x_predict(1:3,i);                %duvida se é x_predict ou x_update mas é igual
    Va = norm(vr_b);
    Lu = data(i).h/(0.177+0.000823*data(i).h)^1.2;
    Lv = Lu;
    Lw = data(i).h;
    
    df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);
    dVa_dus = - Va^-1*(Rot*d1)'*vr_b;    
    dVa_dvs = - Va^-1*(Rot*d2)'*vr_b;      
    dVa_dws = - Va^-1*(Rot*d3)'*vr_b;      
    df_dv_s = [dt*x_update(4,i-1)/Lu*dVa_dus, dt*x_update(4,i-1)/Lu*dVa_dvs, dt*x_update(4,i-1)/Lu*dVa_dws;...
        dt*x_update(5,i-1)/Lv*dVa_dus, dt*x_update(5,i-1)/Lv*dVa_dvs, dt*x_update(5,i-1)/Lv*dVa_dws;...
        dt*x_update(6,i-1)/Lw*dVa_dus, dt*x_update(6,i-1)/Lw*dVa_dvs, dt*x_update(6,i-1)/Lw*dVa_dws];
    F = [Id zero zero; df_dv_s df_dv_t zero; zero zero Id];   
    
    Vwg = sqrt(data(i).vnorth^2 + data(i).veast^2 + data(i).vdown^2);
    sigma_u = Vwg*0.1/(0.177+0.000823*data(i).h)^0.4;
    sigma_v = sigma_u;
    sigma_w = 0.1*Vwg;
    
    Q = ([a_us a_vs a_ws a_ut*sigma_u*sqrt(2*dT*Va/Lu) ...
        a_vt*sigma_v*sqrt(2*dt*Va/Lv) a_wt*sigma_w*sqrt(2*dt*Va/Lw) ...  
        a_CL0 a_CLalpha a_gamma])*dt^2;
    
    P_predict{i,1} = F*P_update{i-1,1}*F' + Q;
    
    alpha(i) = atan2(vr_b(3),vr_b(1));
    beta(i) = atan2(vr_b(2),Va);
    
    Lr = chol(sigma_vv,'lower');
    vk  = Lr*randn(2,1);
    z(:,i) = [data(i).fz; data(i).u] + vk;                  
    output_func(:,i) = [-K*Va^2*(x_predict(7,i)+x_predict(8,i)*alpha(i)); ...           %%duvida se é x_predict ou x_update mas penso que é predict pelo wikipedia
        d1*Rot*(x_predict(1:3,i)+x_predict(4:6,i))+x_predict(end,i)*data(i).ur_m];
    y(:,i) = z(:,i) - output_func(:,i);

    dh1_dus = 2*K*(Rot*d1)'*vr_b*(x_predict(7,i) + +x_predict(8,i)*alpha(i)) + (- Rot(3,1)*vr_b(i) + ...
        Rot(1,1)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
    dh1_dvs = 2*K*(Rot*d2)'*vr_b*(x_predict(7,i) + x0(8,i)*alpha(i)) + (- Rot(3,2)*vr_b(1) + ...
        Rot(1,2)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
    dh1_dws = 2*K*(Rot*d3)'*vr_b*(x_predict(7,i) + x_predict(8,i)*alpha(i)) + (- Rot(3,3)*vr_b(1) + ...
        Rot(1,3)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
    dh1_dut = K*Va^2*x_predict(8,i)*(Rot(3,1)*vr_b(1) - Rot(1,1)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
    dh1_dvt = K*Va^2*x_predict(8,i)*(Rot(3,2)*vr_b(1) - Rot(1,2)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
    dh1_dwt = K*Va^2*x_predict(8,i)*(Rot(3,3)*vr_b(1) - Rot(1,3)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
    
    H = [dh1_dus dh1_dvs dh1_dws dh1_dut dh1_dvt dh1_dwt -K*Va^2 ...
        -K*Va^2*alpha(i) 0; d1'*Rot d1'*Rot 0 0 data(i).ur_m];
    
    S{i,1} = H*P_predict{i,1}*H' + R;
    
    K_gain{i,1} = P_predict{i,1}*H'\S{i,1};
    
    x_update(:,i) = x_predict(:,i) + K_gain{i,1}*y(:,i);
    
    P_update{i,1} = (eye(9) - K_gain{i,1}*H)*P_predict{i,1};
    
end
    

%% Wind modelling

function [delta_v_t,Lu,Lv,Lw] = turbulent_wind_modelling(h,Vwg,dt,Va,v_t,nu,nv,nw)

Lu = h/(0.177+0.000823*h)^1.2;
Lv = Lu;
Lw = h;
sigma_u = Vwg*0.1/(0.177+0.000823*h)^0.4;
sigma_v = sigma_u;
sigma_w = 0.1*Vwg;

delta_v_t = -dt*Va*[u_t/Lu v_t/Lv w_t/Lw]' + ...
    [sigma_u*sqrt(2*dt*Va/Lu)*nu sigma_v*sqrt(2*dt*Va/Lv)*nv sigma_w*sqrt(2*dt*Va/Lw)*nw]';
end