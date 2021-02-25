% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - José Neves
%          - Pedro Martins
%          - Simão Caeiro
%          - João Moura

% AoA and sideslip angles estimation
%clear
%load data_3_-3_0__0_0_0.mat
% Aircraft parameters
mass    = 25;
g       = 9.8;
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
a = 0.000001*[a_us a_vs a_ws a_ut a_vt a_wt a_CL0 a_CLalpha a_gamma];
R = 5*diag([1 0.6]);
sigma_vv = [0.1 0; 0 0.1];

% Initial conditions
x0 = [0 0 0 0 0 0 0 1 1]';
P0 =1.5*diag([1e-2 1e-2 1e-4 1e-5 1e-5 1e-5 1e-5 1e-1 1e-8]);

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

% First iteration starts at 1000

delta_vt = [0 0 0]';
x_predict(:,1) = x0 + [0; 0; 0; delta_vt; 0; 0; 0];

Rot = rotateFromInertialtoBody_R(data(1000).phi, data(1000).theta, data(1000).psi);
vr_b = [data(1000).u data(1000).v data(1000).w]' - Rot*x0(1:3);
Va = norm(vr_b);
Lu = data(1000).alt/(0.177+0.000823*data(1000).alt)^1.2;
Lv = Lu;
Lw = data(1000).alt;

df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);
dVa_dus = - Va^-1*(Rot*d1)'*vr_b;      % Va ^-1
dVa_dvs = - Va^-1*(Rot*d2)'*vr_b;      % Va ^-1
dVa_dws = - Va^-1*(Rot*d3)'*vr_b;      % Va ^-1
df_dv_s = [dt*x0(4)/Lu*dVa_dus, dt*x0(4)/Lu*dVa_dvs, dt*x0(4)/Lu*dVa_dws;...
    dt*x0(5)/Lv*dVa_dus, dt*x0(5)/Lv*dVa_dvs, dt*x0(5)/Lv*dVa_dws;...
    dt*x0(6)/Lw*dVa_dus, dt*x0(6)/Lw*dVa_dvs, dt*x0(6)/Lw*dVa_dws];
Id = eye(3);
zero = zeros(3);
F = [Id zero zero; df_dv_s df_dv_t zero; zero zero Id];   

%Vwg = sqrt(data(1).vnorth^2 + data(1).veast^2 + data(1).vdown^2);
Vwg = 2;
sigma_u = Vwg*0.1/(0.177+0.000823*data(1000).alt)^0.4;
sigma_v = sigma_u;
sigma_w = 0.1*Vwg;

Q = ([a(1) a(2) a(3) a(4)*sigma_u*sqrt(2*dt*Va/Lu) ...
        a(5)*sigma_v*sqrt(2*dt*Va/Lv) a(6)*sigma_w*sqrt(2*dt*Va/Lw) ...     %Possivelmente existe erro no paper, na entrada 6 onde tem sigma_v poderá ser  sigma_w)
        a(7) a(8) a(9)])*dt^2;

P_predict{1,1} = F*P0*F'+ Q;

alpha(1) = atan2(vr_b(3),vr_b(1));
beta(1) = atan2(vr_b(2),Va);

Lr = chol(sigma_vv,'lower');                                                     
vk  = Lr*randn(2,1);
%z(:,1) = [data(1).fz; data(1).u] + vk;                  %nao sei se temos o az ou o fz
z(:,1) = [data(1000).az-g*cos(data(1000).theta)*cos(data(1000).phi); data(1000).u] + vk;
output_func(:,1) = [-K*Va^2*(x0(7)+x0(8)*alpha(1)); ...
    d1'*Rot*(x0(1:3)+x0(4:6))+x0(end)*data(1000).u_r];
%y(:,1) = z(:,1) - output_func(:,1);

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
    -K*Va^2*alpha(1) 0; d1'*Rot d1'*Rot 0 0 data(1).u_r];

y(:,1) = z(:,1) - H*x_predict(:,1);


S{1,1} = H*P_predict{1,1}*H' + R;

K_gain{1,1} = P_predict{1,1}*H'*S{1,1}^-1;

x_update(:,1) = x_predict(:,1) + K_gain{1,1}*y(:,1);

P_update{1,1} = (eye(9) - K_gain{1,1}*H)*P_predict{1,1};


for i = 2:length(data)-1000
    
    delta_vt_predict = -x_update(4:6,i-1)*dt*[Va/Lu Va/Lv Va/Lw];
    x_predict(:,i) = x_update(:,i-1) + [0; 0; 0; delta_vt; 0; 0; 0];
    
    Rot = rotateFromInertialtoBody_R(data(i+1000).phi, data(i+1000).theta, data(i+1000).psi);
    vr_b = [data(i+1000).u data(i+1000).v data(i+1000).w]' - Rot*x_predict(1:3,i);                %duvida se é x_predict ou x_update mas é igual
    Va = norm(vr_b);
    Lu = data(i+1000).alt/(0.177+0.000823*data(i+1000).alt)^1.2;
    Lv = Lu;
    Lw = data(i+1000).alt;
    
    df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);
    dVa_dus = - Va^-1*(Rot*d1)'*vr_b;    
    dVa_dvs = - Va^-1*(Rot*d2)'*vr_b;      
    dVa_dws = - Va^-1*(Rot*d3)'*vr_b;      
    df_dv_s = [dt*x_update(4,i-1)/Lu*dVa_dus, dt*x_update(4,i-1)/Lu*dVa_dvs, dt*x_update(4,i-1)/Lu*dVa_dws;...
        dt*x_update(5,i-1)/Lv*dVa_dus, dt*x_update(5,i-1)/Lv*dVa_dvs, dt*x_update(5,i-1)/Lv*dVa_dws;...
        dt*x_update(6,i-1)/Lw*dVa_dus, dt*x_update(6,i-1)/Lw*dVa_dvs, dt*x_update(6,i-1)/Lw*dVa_dws];
    F = [Id zero zero; df_dv_s df_dv_t zero; zero zero Id];   
    
    %Vwg = sqrt(data(i).vnorth^2 + data(i).veast^2 + data(i).vdown^2);
    Vwg=2;
    sigma_u = Vwg*0.1/(0.177+0.000823*data(i+1000).alt)^0.4;
    sigma_v = sigma_u;
    sigma_w = 0.1*Vwg;
    
    Q = ([a(1) a(2) a(3) a(4)*sigma_u*sqrt(2*dt*Va/Lu) ...
        a(5)*sigma_v*sqrt(2*dt*Va/Lv) a(6)*sigma_w*sqrt(2*dt*Va/Lw) ...     %Possivelmente existe erro no paper, na entrada 6 onde tem sigma_v poderá ser  sigma_w)
        a(7) a(8) a(9)])*dt^2;
    
    P_predict{i,1} = F*P_update{i-1,1}*F' + Q;
    P_predict{1,1} = F*P0*F'+ Q;

    
    alpha(i) = atan2(vr_b(3),vr_b(1));
    beta(i) = atan2(vr_b(2),Va);
    
    Lr = chol(sigma_vv,'lower');
    vk  = Lr*randn(2,1);
    %z(:,i) = [data(i).fz; data(i).u] + vk; 
    z(:,i) = [data(i+1000).az-g*cos(data(i+1000).theta)*cos(data(i+1000).phi); data(i+1000).u] + vk;
    
    output_func(:,i) = [-K*Va^2*(x_predict(7,i)+x_predict(8,i)*alpha(i)); ...           %%duvida se é x_predict ou x_update mas penso que é predict pelo wikipedia
        d1'*Rot*(x_predict(1:3,i)+x_predict(4:6,i))+x_predict(end,i)*data(i+1000).u_r];
    %y(:,i) = z(:,i) - output_func(:,i);

    dh1_dus = 2*K*(Rot*d1)'*vr_b*(x_predict(7,i) + +x_predict(8,i)*alpha(i)) + (- Rot(3,1)*vr_b(1) + ...
        Rot(1,1)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
    dh1_dvs = 2*K*(Rot*d2)'*vr_b*(x_predict(7,i) + x_predict(8,i)*alpha(i)) + (- Rot(3,2)*vr_b(1) + ...
        Rot(1,2)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
    dh1_dws = 2*K*(Rot*d3)'*vr_b*(x_predict(7,i) + x_predict(8,i)*alpha(i)) + (- Rot(3,3)*vr_b(1) + ...
        Rot(1,3)*vr_b(3))/(vr_b(1)^2 + vr_b(3)^2);
    dh1_dut = - K*Va^2*x_predict(8,i)*(Rot(3,1)*vr_b(1) - Rot(1,1)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
    dh1_dvt = - K*Va^2*x_predict(8,i)*(Rot(3,2)*vr_b(1) - Rot(1,2)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
    dh1_dwt = - K*Va^2*x_predict(8,i)*(Rot(3,3)*vr_b(1) - Rot(1,3)*vr_b(3))/(vr_b(3)^2 + vr_b(1)^2);
    
    H = [dh1_dus dh1_dvs dh1_dws dh1_dut dh1_dvt dh1_dwt -K*Va^2 ...
        -K*Va^2*alpha(i) 0; d1'*Rot d1'*Rot 0 0 data(i+1000).u_r];
    
    y(:,i) = z(:,i) - H*x_predict(:,i);

    S{i,1} = H*P_predict{i,1}*H' + R;
    
    K_gain{i,1} = P_predict{i,1}*H'*S{i,1}^-1;
    
    x_update(:,i) = x_predict(:,i) + K_gain{i,1}*y(:,i);
    
    P_update{i,1} = (eye(9) - K_gain{i,1}*H)*P_predict{i,1};
    
end

% GRAFICOS
time = [data.time]';

alpha=rad2deg(alpha);
alpha_simulado=rad2deg([data.AoA]);

for i=1:23000
    error_alpha(i)=alpha_simulado(i+1000)-alpha(i);
end
RMSE_alpha = mean(abs(error_alpha));

figure()
alpha=alpha';
plot(time(1:end-1000),alpha_simulado(1001:end),'LineWidth',2);
hold on
plot(time(1:end-1000),alpha(1:end-1000),'LineWidth',2);
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$\alpha$ (rad)','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)

figure()
plot(time(1:end-1000),error_alpha,'LineWidth',2);
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('Erro de $\alpha$ (graus)','Interpreter','latex','FontSize',18)
title(['RMSE-  ',num2str(RMSE_alpha),'graus'],'FontSize',14);
%%

%beta
beta=rad2deg(beta);
beta_simulado=rad2deg([data.beta]);

for i=1:23000
    error_beta(i)=beta_simulado(i+1000)-beta(i);
end
RMSE_beta = mean(abs(error_beta));

figure()
beta=beta';
plot(time(1:end-1000),beta_simulado(1001:end),'LineWidth',2);
hold on
plot(time(1:end-1000),beta(1:end-1000),'LineWidth',2);

xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$\beta$ (graus)','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)

figure()
plot(time(1:end-1000),error_beta,'LineWidth',2);
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('Erro de $\beta$ (graus)','Interpreter','latex','FontSize',18)
title(['RMSE-  ',num2str(RMSE_beta),'graus'],'FontSize',14);

 
% vento nominal norte
figure()

plot(time(1:end-1000), x_update(1,1:end-1000),'LineWidth',2)
hold on
plot([data.time], 3*ones(1,length(data)),'LineWidth',2)
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$u_n$','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)
title('Velocidade do vento nominal - north')

% vento nominal este
figure()
plot(time(1:end-1000), x_update(2,1:end-1000),'LineWidth',2)
hold on
plot([data.time], -3*ones(1,length(data)),'LineWidth',2)
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$v_n$','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)
title('Velocidade do vento nominal - east')

% vento nominal down
figure()
plot(time(1:end-1000), x_update(3,1:end-1000),'LineWidth',2)
hold on
plot(time(1:end-1000), 0*ones(1,length(data)-1000),'LineWidth',2)
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$w_n$','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)
title('Velocidade do vento nominal - down')

% vento turbulento norte
figure()

plot(time(1:end-1000), x_update(4,1:end-1000),'LineWidth',2)
hold on
plot([data.time], 0*ones(1,length(data)),'LineWidth',2)
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$u_t$','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)
title('Velocidade do vento turbulento - north')

% vento turbulento este
figure()
plot(time(1:end-1000), x_update(5,1:end-1000),'LineWidth',2)
hold on
plot([data.time], 0*ones(1,length(data)),'LineWidth',2)
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$v_t$','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)
title('Velocidade do vento turbulento - east')

% vento turbulento este
figure()
plot(time(1:end-1000), x_update(6,1:end-1000),'LineWidth',2)
hold on
plot(time(1:end-1000), 0*ones(1,length(data)-1000),'LineWidth',2)
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$w_t$','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)
title('Velocidade do vento turbulento - down')


%%
trace_buffer=zeros(1,length(data));
for i=1:23000
trace_buffer(i)=trace(P_update{i,1});
end

figure
plot(time(1:end-1000), trace_buffer(1:end-1000),'r','LineWidth',2)
xlabel('time (s)')
ylabel('Trace')
title('Trace evolution')
