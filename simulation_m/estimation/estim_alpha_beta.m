% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - José Neves
%          - Pedro Martins
%          - Simão Caeiro

% AoA and sideslip angle estimation

% Model:
% u = d_1*R*v_w + u_r_m*gamma
% v_w = constant; gamma = constant

d_1 = [1;0;0];
R = 1;                  % sensor noise variance 
Q = diag([10e-3,10e-3,10e-6,10e-8]);    % white noise covariance  

% Sampling rate
dt = 0.01;

% Initial conditions:
P_0 = diag([10e-2,10e-2,10e-6,10e-4]); 
v_w_estim_0 = [0;0;0];
gamma_0 = 1;
x_estim_0 = [v_w_estim_0;gamma_0];

% Initializing x_estim and K:
x_estim = zeros(4,length(data));    
K = zeros(4,length(data));

for i = 1:length(data)
    if i == 1
        Rot = rotateFromInertialtoBody_R(data(i).phi,data(i).theta,...
            data(i).psi);
        C = [d_1'*Rot,data(i).Va];
        P_dot = Q - P_0*C'/R*C*P_0;
        P = P_dot*dt + P_0;
        K = P*C'/R;
        x_estim_dot = K*C*x_estim_0;
        x_estim(:,i) = x_estim_dot * dt + x_estim_0;
    else
        Rot = rotateFromInertialtoBody_R(data(i).phi,data(i).theta,...
            data(i).psi);
        C = [d_1'*Rot,data(i).Va];
        P_dot = Q - P*C'/R*C*P;
        P = P_dot*dt + P;
        K = P*C'/R;
        x_estim_dot = K*C*x_estim(:,i-1);
        x_estim(:,i) = x_estim_dot * dt + x_estim(:,i-1);
    end
end

V_r = [data.u; data.v; data.w] - x_estim(3,:);
u_r = V_r(1,:); v_r = V_r(2,:); w_r = V_r(3,:);

alpha = zeros(1, length(data)); beta = zeros(1, length(data));

for i = 1:length(data)
    alpha(i) = atan(w_r(i)/u_r(i));
    beta(i) = asin(v_r(i)/sqrt(u_r(i)^2 + v_r(i)^2 + w_r(i)^2));
end

error_vector_alpha = [data.AoA] - alpha;
error_vector_beta = [data.beta] - beta;

plot([data.time], error_vector_alpha,'LineWidth',2)
xlabel('time (s)')
ylabel('error (rad)')
title('Angle of attack - error')

figure
plot([data.time], error_vector_beta,'r','LineWidth',2)
xlabel('time (s)')
ylabel('error (rad)')
title('Sideslip angle - error')
