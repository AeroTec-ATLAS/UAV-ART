% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - José Neves
%          - Pedro Martins
%          - Simão Caeiro

% AoA and sideslip angles estimation

x0 = [0 0 0 0 0 0 0 1 1]';
P0 = diag([1e-2 1e-2 1e-4 1e-5 1e-5 1e-5 1e-5 1e-1 1e-8]);
a = [1e-7 1e-7 1e-10 5e2 5e2 2e2 1e-6 1e-10 1e-15]';
R = diag([1 0.6]);
sigma_v = [0.1; 0.1];
d1 = [1; 0; 0];
d2 = [0; 1; 0];
d3 = [0; 0; 1];

for i = 1:length(data)
    
    % Predict
    
    xk_k_1 = xk_1_k_1 + [0 0 0 delta_v_t 0 0 0]';
    
    Pk_k_1 = Fk*Pk_1_k_1*Fk' + Qk;
    
    % Update
    % Noise generation
    Lr = chol(R,'lower');
    vk  = Lr*randn(2,1);
    
    zk = [data(i).fz; data(i).u] + vk;
    output_func = [-K*Va^2*(CL0+CLa*alpha); d1*Rot*(vs+vt) + gamma*ur_m];
    
    yk = zk - output_func;
    
    % Jacobian - state transition
    
    df_dv_t = diag([1-dt*Va/Lu 1-dt*Va/Lv 1-dt*Va/Lw]);
    Rot = rotateFromInertialtoBody_R(data.phi(i), data.theta(i),data.psi(i));
    dVa_dus = - data.Va(i)*(Rot*d1)'*vr;
    dVa_dvs = - data.Va(i)*(Rot*d2)'*vr;
    dVa_dws = - data.Va(i)*(Rot*d3)'*vr;
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