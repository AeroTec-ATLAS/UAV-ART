% UAV-ART // Aerotec - Nucleo de estudantes de Engenharia Aeroespacial
% Estimation of aerodynamic coefficients 
% Authors: - Mariana Ribeiro
clear all; 
close all;
clc; 

% Parameters
mass    = 25;
rho     = 1.2682;
S_wing  = 0.55;
b       = 2.8956;
c       = 0.18994;
g       = 9.8;
Ixx     = 0.8244;
Iyy     = 1.135;
Izz     = 1.759;
Ixz     = 0.1204;
S_prop  = 0.2027;
k_motor = 80;
C_prop  = 1.0;

% Theoretical coefficients (for comparison)
C.C_L_0         = 0.28;
C.C_L_alpha     = 3.45;
C.C_L_q         = 0;
C.C_L_delta_e   = -0.36;
C.C_D_0         = 0.03;
C.C_D_alpha     = 0.30;
C.C_D_q         = 0;
C.C_D_delta_e   = 0;
C.C_m_0         = -0.02338;
C.C_m_alpha     = -0.38;
C.C_m_q         = -3.6;
C.C_m_delta_e   = -0.5;

C.C_Y_0         = 0;
C.C_Y_beta      = -0.98;
C.C_Y_p         = 0;
C.C_Y_r         = 0;
C.C_Y_delta_a   = 0;
C.C_Y_delta_r   = -0.17;
C.C_ell_0       = 0;
C.C_ell_beta    = -0.12;
C.C_ell_p       = -0.26;
C.C_ell_r       = 0.14;
C.C_ell_delta_a = 0.08;
C.C_ell_delta_r = 0.105;
C.C_n_0         = 0;
C.C_n_beta      = 0.25;
C.C_n_p         = 0.022;
C.C_n_r         = -0.35;
C.C_n_delta_a   = 0.06;
C.C_n_delta_r   = -0.032;

%Get the data from the logs into a struct  
[data] = read_data();

%Compute linear accelerations - finite differences method 
[u_dot] = finite_differences([data.u]); 
[v_dot] = finite_differences([data.v]); 
[w_dot] = finite_differences([data.w]); 


%Compute external forces
[fx, fy, fz] = external_forces(mass, u_dot, v_dot, w_dot, data);

%Compute lift, drag and lateral forces 
[F_Lift, Fy, F_Drag] = compute_forces(mass, g, rho, S_prop, k_motor, C_prop, data, fx, fy, fz);

%Compute lift and drag coefficients 
[CL] = compute_coefficients(F_Lift, rho, S_wing, [data.Va], 1); 
[CD] = compute_coefficients(F_Drag, rho, S_wing, [data.Va], 1);

% t = [data.time];
% y = CL;
% figure()
% plot(t, y, 'ro');
% 
% beta_CL_coeffs0 = [C.C_L_0 C.C_L_alpha C.C_L_delta_e]; 
% [xdata] = long_variables_matrix(data, c);
% 
% F = @(beta_CL_coeffs, xdata)beta_CL_coeffs(1)*xdata(:,1)+ beta_CL_coeffs(2)*xdata(:,2) + beta_CL_coeffs(3)*xdata(:,3);
% curve = lsqcurvefit(F,beta_CL_coeffs0,xdata,y');
% CL_fitted = curve(1)*xdata(:,1) + curve(2)*xdata(:,2)+ curve(3)*xdata(:,3);
% plot (t, CL, 'o', t, CL_fitted);
% legend('Data','Fitted curve')
% title('Data and Fitted Curve')
% 
% mean = (CL' + CL_fitted)/2;
% variance = ((CL'-mean).^2 + (CL_fitted-mean).^2)/2;
% W = diag(variance);

%Compute lateral force coefficient
[CY] = compute_coefficients(Fy, rho, S_wing, [data.Va], 1);

%Compute angular accelerations - finite differences method 
[p_dot] = finite_differences([data.p]); 
[q_dot] = finite_differences([data.q]); 
[r_dot] = finite_differences([data.r]); 

%Compute roll, pich and yaw moments
[l, m, n] = compute_moments(Ixx, Iyy, Izz, Ixz, p_dot, q_dot, r_dot, data);

%Compute roll, pitch and yaw moment coefficients (extra term is for chord-c and wingspan-b)
[Cl] = compute_coefficients(l, rho, S_wing, [data.Va], b); 
[Cm] = compute_coefficients(m, rho, S_wing, [data.Va], c);
[Cn] = compute_coefficients(n, rho, S_wing, [data.Va], b);

% *** Weighted Least Squares ***

t = [data.time];

[X_long] = long_variables_matrix(data, c);

%For the complete model
beta0_CL = [C.C_L_0 C.C_L_alpha C.C_L_q C.C_L_delta_e]; 
beta0_CD = [C.C_D_0 C.C_D_alpha C.C_D_q C.C_D_delta_e]; 
beta0_Cm= [C.C_m_0 C.C_m_alpha C.C_m_q C.C_m_delta_e];

%For the simplified model
% beta0_CL = [C.C_L_0 C.C_L_alpha C.C_L_delta_e]; 
% beta0_CD = [C.C_D_0 C.C_D_alpha C.C_D_delta_e]; 
% beta0_Cm= [C.C_m_0 C.C_m_alpha C.C_m_delta_e]; 

[CL_fitted, W_CL] = long_curve_fitting(X_long, CL', beta0_CL, t); 
[CD_fitted, W_CD] = long_curve_fitting(X_long, CD', beta0_CD, t); 
[Cm_fitted, W_Cm] = long_curve_fitting(X_long, Cm', beta0_Cm, t); 

%Compute CL, CD and Cm coefficients with WLS 
[CL_coeffs] = wls(X_long, CL', W_CL, 0);
[CD_coeffs] = wls(X_long, CD', W_CD, 0);
[Cm_coeffs] = wls(X_long, Cm', W_Cm, 0);



[X_lat] = lat_variables_matrix(data, b);

%For the complete model
beta0_CY = [C.C_Y_0 C.C_Y_beta C.C_Y_p C.C_Y_r C.C_Y_delta_a C.C_Y_delta_r]; 
beta0_Cl = [C.C_ell_0 C.C_ell_beta C.C_ell_p C.C_ell_r C.C_ell_delta_a C.C_ell_delta_r]; 
beta0_Cn= [C.C_n_0 C.C_n_beta C.C_n_p C.C_n_r C.C_n_delta_a C.C_n_delta_r]; 

%For the simplified model
% beta0_CY = [C.C_Y_0 C.C_Y_beta C.C_Y_delta_a]; 
% beta0_Cl = [C.C_ell_0 C.C_ell_beta C.C_ell_delta_a]; 
% beta0_Cn= [C.C_n_0 C.C_n_beta C.C_n_delta_a]; 

[CY_fitted, W_CY] = lat_curve_fitting(X_lat, CY', beta0_CY, t); 
[Cl_fitted, W_Cl] = lat_curve_fitting(X_lat, Cl', beta0_Cl, t); 
[Cn_fitted, W_Cn] = lat_curve_fitting(X_lat, Cn', beta0_Cn, t); 

%Compute CY, Cl and Cn coefficients with WLS 
k = diag(ones(6,1))*10^(-6); 
%k = diag(ones(3,1))*10^(-6); %simplified model
[CY_coeffs] = wls(X_lat, CY', W_CY, k);
[Cl_coeffs] = wls(X_lat, Cl', W_Cl, k);
[Cn_coeffs] = wls(X_lat, Cn', W_Cn, k);

%%
% da estrutura tiramos FD, FY, FD, l, m e n em cada ponto 
% com as derivadas anteriores determinamos os coeficientes totais e com
% esses tiramos as forcas e depois podemos comparar com o que esta no log

[CL_est] = long_compute_total_coeff(CL_coeffs, data, c);
[CD_est] = long_compute_total_coeff(CD_coeffs, data, c);
[Cm_est] = long_compute_total_coeff(Cm_coeffs, data, c);


[FL_est] = compute_aero_forces_moments(CL_est, rho, S_wing, [data.Va], 1);
[FD_est] = compute_aero_forces_moments(CD_est, rho, S_wing, [data.Va], 1);
[m_est] = compute_aero_forces_moments(Cm_est, rho, S_wing, [data.Va], c);

[CY_est] = lat_compute_total_coeff(CY_coeffs, data, b);
[Cl_est] = lat_compute_total_coeff(Cl_coeffs, data, b);
[Cn_est] = lat_compute_total_coeff(Cn_coeffs, data, b);


[FY_est] = compute_aero_forces_moments(CY_est, rho, S_wing, [data.Va], 1);
[l_est] = compute_aero_forces_moments(Cl_est, rho, S_wing, [data.Va], b);
[n_est] = compute_aero_forces_moments(Cn_est, rho, S_wing, [data.Va], b);

%Plots
error_plots([data.time], -[data.F_L], FL_est, "FL"); 
error_plots([data.time], [data.F_D], FD_est, "FD");  
error_plots([data.time], [data.F_Y], FY_est, "FY"); 
error_plots([data.time], [data.l], l_est, "l"); 
error_plots([data.time], [data.m], m_est, "m"); 
error_plots([data.time], [data.n], n_est, "n"); 

%%
[CL_est] = long_compute_total_coeff(CL_coeffs, data, c);
[CD_est] = long_compute_total_coeff(CD_coeffs, data, c);
[Cm_est] = long_compute_total_coeff(Cm_coeffs, data, c);

[CY_est] = lat_compute_total_coeff(CY_coeffs, data, b);
[Cl_est] = lat_compute_total_coeff(Cl_coeffs, data, b);
[Cn_est] = lat_compute_total_coeff(Cn_coeffs, data, b);

[CL_real] = compute_coefficients(-[data.F_L], rho, S_wing, [data.Va], 1); 
[CD_real] = compute_coefficients([data.F_D], rho, S_wing, [data.Va], 1);
[CY_real] = compute_coefficients([data.F_Y], rho, S_wing, [data.Va], 1);

[Cl_real] = compute_coefficients([data.l], rho, S_wing, [data.Va], b); 
[Cm_real] = compute_coefficients([data.m], rho, S_wing, [data.Va], c);
[Cn_real] = compute_coefficients([data.n], rho, S_wing, [data.Va], b);


%Plots
error_plots([data.time], CL_real, CL_est, "CL"); %sinal trocado?
error_plots([data.time], CD_real, CD_est, "CD"); 
error_plots([data.time], CY_real, CY_est, "CY"); 
error_plots([data.time], Cl_real, Cl_est, "Cl"); 
error_plots([data.time], Cm_real, Cm_est, "Cm"); 
error_plots([data.time], Cn_real, Cn_est, "Cn"); 

%% Modelo simplificado

% % Coef.long - eliminar dependencia da v.angular de picada (q)
% % Coef.lateral - eliminar dependencia das v.angulares e delta_t
% 
% [X_long_s] = long_variables_matrix(data, c);
% [CL_coeffs_s] = mlr(X_long_s, CL', 0);
% [CD_coeffs_s] = mlr(X_long_s, CD', 0);
% [Cm_coeffs_s] = mlr(X_long_s, Cm', 0);
% 
% 
% [X_lat_s] = lat_variables_matrix(data, b);
% [CY_coeffs_s] = mlr(X_lat_s, CY', 0);
% [Cl_coeffs_s] = mlr(X_lat_s, Cl', 0);
% [Cn_coeffs_s] = mlr(X_lat_s, Cn', 0);
% 
% %***
% [CL_est_s] = long_compute_total_coeff(CL_coeffs_s, data, c);
% [CD_est_s] = long_compute_total_coeff(CD_coeffs_s, data, c);
% [Cm_est_s] = long_compute_total_coeff(Cm_coeffs_s, data, c);
% 
% [CY_est_s] = lat_compute_total_coeff(CY_coeffs_s, data, b);
% [Cl_est_s] = lat_compute_total_coeff(Cl_coeffs_s, data, b);
% [Cn_est_s] = lat_compute_total_coeff(Cn_coeffs_s, data, b);
% 
% 
% %Plots
% error_plots([data.time], CL_real, CL_est_s, "CL - Simplified Model"); %sinal trocado?
% error_plots([data.time], CD_real, CD_est_s, "CD - Simplified Model"); 
% error_plots([data.time], CY_real, CY_est_s, "CY - Simplified Model"); 
% error_plots([data.time], Cl_real, Cl_est_s, "Cl - Simplified Model "); 
% error_plots([data.time], Cm_real, Cm_est_s, "Cm - Simplified Model"); 
% error_plots([data.time], Cn_real, Cn_est_s, "Cn - Simplified Model"); 

%%





