% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - José Neves
%          - Pedro Martins
%          - Simão Caeiro

% AoA and sideslip angle estimation

% Model:
% u = d_1*R*v_w + u_r_m*gamma
% v_w = constant; gamma = constant

close all

d_1 = [1;0;0];
R = 1;                                  % sensor noise variance 
Q = diag([10e-3,10e-3,10e-6,10e-8]);    % white noise covariance  % Q = diag([10e-3,10e-3,10e-6,10e-8]); 

% Sampling time
dt = 0.01;

% Initializing x_hat, P_hat and K:
xhat = zeros(4,length(data));   
Phat = cell(1,length(data));
K = zeros(4,length(data));

% Initial conditions:
P_0 = diag([10e-2,10e-2,10e-6,10e-4]); 
vw_0 = [0;0;0];
gamma_0 = 1;
xhat_0 = [vw_0;gamma_0];

% Matrices A & B
A = eye(4);

for i = 1:length(data)
    if i == 1
        % Predict
        xaux = A*xhat_0; 
        Paux = A*P_0*A' + Q;
        % Update
        Rot = rotateFromInertialtoBody_R(data(1).phi,data(1).theta,...
            data(1).psi);
        C = [d_1'*Rot,data(1).Va];
        y = data(1).u - C*xaux;
        S = C*Paux*C' + R;
        K = P_0*C'/S;
        xhat(:,1) = xaux + K*y;
        Phat{1} = (eye(4) - K*C)*Paux;
    else
         % Predict
        xaux = A*xhat(:,i-1); 
        Paux = A*Phat{i-1}*A' + Q;
        % Update
        Rot = rotateFromInertialtoBody_R(data(i).phi,data(i).theta,...
            data(i).psi);
        C = [d_1'*Rot,data(i).Va];
        y = data(i).u - C*xaux;
        S = C*Paux*C' + R;
        K = Phat{i-1}*C'/S;
        xhat(:,i) = xaux + K*y;
        Phat{i} = (eye(4) - K*C)*Paux;
    end
end

V_r = [data.u; data.v; data.w] - xhat(1:3,:);
u_r = V_r(1,:); v_r = V_r(2,:); w_r = V_r(3,:);

alpha = zeros(1, length(data)); beta = zeros(1, length(data));

for i = 1:length(data)
    alpha(i) = atan(w_r(i)/u_r(i));
    beta(i) = asin(v_r(i)/sqrt(u_r(i)^2 + v_r(i)^2 + w_r(i)^2));
end

% Gráficos das variáveis estimadas
% u_w
figure
plot([data.time], xhat(1,:),'LineWidth',2)
hold on
plot([data.time], 3*ones(1,length(data)),'LineWidth',2)
xlabel('time (s)')
ylabel('u_w (m/s)')
legend('estimado','teórico')
title('Velocidade do vento longitudinal - u_w')

% v_w
figure
plot([data.time], xhat(2,:),'LineWidth',2)
hold on
plot([data.time], 3*ones(1,length(data)),'LineWidth',2)
xlabel('time (s)')
ylabel('v_w (m/s)')
legend('estimado','teórico')
title('Velocidade do vento lateral - v_w')

% w_w
figure
plot([data.time], xhat(3,:),'LineWidth',2)
hold on
plot([data.time], 3*ones(1,length(data)),'LineWidth',2)
xlabel('time (s)')
ylabel('w_w (m/s)')
legend('estimado','teórico')
title('Velocidade do vento vertical - w_w')

% gamma
figure
plot([data.time], xhat(4,:),'LineWidth',2)
xlabel('time (s)')
ylabel('Gamma')
title('Gamma')

%% Gráficos dos erros

error_vector_alpha = [data.AoA] - alpha;
error_vector_beta = [data.beta] - beta;

figure
plot([data.time], error_vector_alpha,'LineWidth',2)
xlabel('time (s)')
ylabel('error (rad)')
title('Angle of attack - error')

figure
plot([data.time], error_vector_beta,'r','LineWidth',2)
xlabel('time (s)')
ylabel('error (rad)')
title('Sideslip angle - error')
