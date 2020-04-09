
load ../params
G = P.G;

T_phi_delta_a       = tf(G.a_phi2,[1,G.a_phi1,0]);
T_p_delta_a         = tf(G.a_phi2,[1,G.a_phi1]);
T_chi_phi           = tf(P.gravity/G.Va_trim,[1,0]);
T_theta_delta_e     = tf(G.a_theta3,[1,G.a_theta1,G.a_theta2]);
T_theta_dot_delta_e = tf([G.a_theta3 0],[1,G.a_theta1,G.a_theta2]);
T_h_theta           = tf(G.Va_trim,[1,0]);
T_h_Va              = tf(G.theta_trim,[1,0]);
T_Va_delta_t        = tf(G.a_V2,[1,G.a_V1]);
T_Va_theta          = tf(-G.a_V3,[1,G.a_V1]);
T_Va                = tf(1,[1,G.a_V1]);
T_v_delta_r         = tf(G.a_beta2,[1,G.a_beta1]);