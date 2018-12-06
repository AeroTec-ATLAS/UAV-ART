function [T_phi_delta_a,T_chi_phi,T_theta_delta_e,T_h_theta,T_h_Va,T_Va_delta_t,T_Va_theta,T_v_delta_r]...
    = compute_tf_model(x_trim,u_trim,P)
% x_trim is the trimmed state,
% u_trim is the trimmed input
% add stuff here

% x_trim(4)
% 
% a_phi2 = (1/2)*P.rho*x_trim(4)^2*P.S*P.b*(P.g3*P.C_ell_delta_a+P.g4*P.C_n_delta_a);
% a_phi1 = (-1/4)*P.rho*x_trim(4)*P.S*P.b^2*(P.g3*P.C_ell_p+P.g4*P.C_n_p);
% a_theta1 = (-1/(4*P.Jy))*P.rho*x_trim(4)*P.c^2*P.S*P.C_m_q;
% a_theta2 = (-1/(2*P.Jy))*P.rho*x_trim(4)^2*P.c*P.S*P.C_m_alpha;

a_phi2 = 0;
a_phi1 = 0;
a_theta1 = 0;
a_theta2 = 0;
a_theta3 = 0;
a_V2 = 0;
a_V1 = 0;
a_V3 = 0;
a_beta2 = 0;
a_beta1 = 0;


Va_trim = x_trim(4); %% CALcular velocidade decentemenye
theta_trim = x_trim(8);
    
% define transfer functions
T_phi_delta_a   = tf([a_phi2],[1,a_phi1,0]);
T_chi_phi       = tf([P.gravity/Va_trim],[1,0]);
T_theta_delta_e = tf(a_theta3,[1,a_theta1,a_theta2]);
T_h_theta       = tf([Va_trim],[1,0]);
T_h_Va          = tf([theta_trim],[1,0]);
T_Va_delta_t    = tf([a_V2],[1,a_V1]);
T_Va_theta      = tf([-a_V3],[1,a_V1]);
T_v_delta_r     = tf([Va_trim*a_beta2],[1,a_beta1]);

end