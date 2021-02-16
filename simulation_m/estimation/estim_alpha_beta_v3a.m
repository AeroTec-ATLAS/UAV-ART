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
S = cell(length(data),1);
K_gain = cell(length(data),1);

% First iteration

delta_vt = [0 0 0]';
x_predict(9,1) = x0 + [0; 0; 0; delta_vt; 0; 0; 0];

Rot = rotateFromInertialtoBody_R(data(1).phi, data(1).theta, data(1).psi);
vr_b = [data(1).u data(1).v data(1).w]' - Rot_init*x0(1:3);
Va = norm(vr_b);
Lu = data(1).h/(0.177+0.000823*data(1).h)^1.2;
Lv = Lu;
Lw = data(1).h;

df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);
dVa_dus = - Va*(Rot*d1)'*vr_b;
dVa_dvs = - Va*(Rot*d2)'*vr_b;
dVa_dws = - Va*(Rot*d3)'*vr_b;
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

Lr = chol(sigma_vv,'lower');                                                     
vk  = Lr*randn(2,1);
z(2,1) = [data(1).fz; data(1).u] + vk;
output_func(2,1) = [-K*Va^2*(x0(7)+x0(8)*alpha(1)); d1*Rot*(x0(1:3)+...
    x0(4:6))+x0(end)*data(1).ur_m];
y(2,1) = z(2,1) - output_func(2,1);


dh1_dus = 2*K*(Rot*d1)'*vr_b*(x0(7) + x0(8)*alpha(1)) + (- Rot(3,1)*vr_b(1) + ...
    Rot(1,1)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
dh1_dvs = 2*K*(Rot*d2)'*vr_b*(x0(7) + x0(8)*alpha(1)) + (- Rot(3,2)*vr_b(1) + ...
    Rot(1,2)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
dh1_dws = 2*K*(Rot*d3)'*vr_b*(x0(7) + x0(8)*alpha(1)) + (- Rot(3,3)*vr_b(1) + ...
    Rot(1,3)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
dh1_dut = - K*Va^2*x0(8)*(Rot(3,1)*vr_b(1) - Rot(1,1)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
dh1_dvt = - K*Va^2*x0(8)*(Rot(3,2)*vr_b(1) - Rot(1,2)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
dh1_dwt = - K*Va^2*x0(8)*(Rot(3,3)*vr_b(1) - Rot(1,3)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);

H = [dh1_dus dh1_dvs dh1_dws dh1_dut dh1_dvt dh1_dwt -K*Va^2 ...
    -K*Va^2*alpha(1) 0; d1'*Rot d1'*Rot 0 0 data(1).ur_m];

S{1,1} = H*P_predict{1,1}*H' + R;

K_gain{1,1} = P_predict{1,1}*H'\S{1,1};

x_update(9,1) = x_predict(9,1) + K_gain{1,1}*y(2,1);

P_update{1,1} = (eye(9) - K_gain{1,1}*H)*P_predict{1,1};

for i = 1:length(data)
    
    % Predict
    
    xk_k_1 = xk_1_k_1 + [0 0 0 delta_v_t 0 0 0]';
    
    Pk_k_1 = Fk*Pk_1_k_1*Fk' + Qk;                                            
    
    % Update
    % Noise generation
    Lr = chol(R,'lower');                                                     
    vk  = Lr*randn(2,1);
    
    zk = [data(i).fz; data(i).u] + vk;
    output_func = [-K*Va^2*(CL0+CLa*alpha); d1*Rot*(vs+vt) + gamma*data(i).ur_m];
    
    yk = zk - output_func;                                                      
    
    % Jacobian - state transition
    
    df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);                         
    Rot = rotateFromInertialtoBody_R(data(i).phi, data(i).theta,data(i).psi);
    dVa_dus = - data(i).Va*(Rot*d1)'*vr;
    dVa_dvs = - data(i).Va*(Rot*d2)'*vr;
    dVa_dws = - data(i).Va*(Rot*d3)'*vr;
    df_dv_s = [dt*u_t/Lu*dVa_dus, dt*u_t/Lu*dVa_dvs, dt*u_t/Lu*dVa_dws;...
        dt*v_t/Lv*dVa_dus, dt*v_t/Lv*dVa_dvs, dt*v_t/Lv*dVa_dws;...
        dt*w_t/Lw*dVa_dus, dt*w_t/Lw*dVa_dvs, dt*w_t/Lw*dVa_dws];
    Id = eye(3);
    zero = zeros(3);
    
    Fk_1 = [Id zero zero; df_dv_s df_dv_t zero; zero zero Id];
    
    % Jacobian - observation matrix
    
    K = rho*S/(2*m);
    dh1_dus = 2*K*(Rot*d1)'*vr*(CL0 + CLa*alpha) + (- Rot(3,1)*ur + ...
       Rot(1,1)*wr)/(ur^2 + wr^2);
    dh1_dvs = 2*K*(Rot*d2)'*vr*(CL0 + CLa*alpha) + (- Rot(3,2)*ur + ...
       Rot(1,2)*wr)/(ur^2 + wr^2);
    dh1_dws = 2*K*(Rot*d3)'*vr*(CL0 + CLa*alpha) + (- Rot(3,3)*ur + ...
       Rot(1,3)*wr)/(ur^2 + wr^2);
    dh1_dut = - K*Va^2*CLa*(Rot(3,1)*ur - Rot(1,1)*wr)/(wr^2 + ur^2);
    dh1_dvt = - K*Va^2*CLa*(Rot(3,2)*ur - Rot(1,2)*wr)/(wr^2 + ur^2);
    dh1_dwt = - K*Va^2*CLa*(Rot(3,3)*ur - Rot(1,3)*wr)/(wr^2 + ur^2);
    
    Hk = [dh1_dus dh1_dvs dh1_dws dh1_dut dh1_dvt dh1_dwt -K*Va^2 ...
        -K*Va^2*alpha 0; d1'*Rot d1'*Rot 0 0 ur_m];
    
  
    Qk = ([a_us a_vs a_ws a_ut*sigma_u*sqrt(2*dT*data(i).Va/Lu) ...
        a_vt*sigma_v*sqrt(2*dT*data(i).Va/Lv) a_wt*sigma_v*sqrt(2*dT*data(i).Va/Lw) ...     %Possivelmente existe erro no paper, na entrada 6 onde tem sigma_v poderá ser  sigma_w)
        a_CL0 a_CLalpha a_gamma])*dT^2;
    
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