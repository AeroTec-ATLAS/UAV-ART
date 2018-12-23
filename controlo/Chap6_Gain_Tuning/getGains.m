function G = getGains(P,G)
    
    %% Roll gains
    
    G.delta_a_max = pi/4;
    e_phi_max = pi/12;
    
    G.k_p_roll = G.delta_a_max/e_phi_max;
    
    bandwidth_roll = sqrt(abs(G.a_phi2)*G.k_p_roll);
    damping_roll = 0.8;
    
    G.k_d_roll = (2*damping_roll*bandwidth_roll-G.a_phi1)/G.a_phi2;
    
    %% Root Locus
%     rootsKi = 0;
%     while(G.k_i_roll<=500)
%         p = [1 (G.a_phi1+G.a_phi2*G.k_d_roll) G.a_phi2*G.k_p_roll G.a_phi2*G.k_i_roll];
%         rootsKi = [rootsKi; roots(p)];
%         G.k_i_roll = G.k_i_roll + 0.5;
%     end
%     
%     
%     scatter(real(rootsKi(2:end,1)), imag(rootsKi(2:end,1)),2);

% Conclusion -> the smalest k_i_roll is the better provided that disturbances are rejected 
    
    G.k_i_roll = 0.6;
    
    %% Course angle
    
    bandwidth_course = bandwidth_roll/38;
    damping_course = 1.8;
    
    G.k_p_course = 2*damping_course*bandwidth_course*G.Va_trim/P.gravity;
    G.k_i_course = bandwidth_course^2*G.Va_trim/P.gravity;
    
    %% Sideslip angle
    
    G.delta_r_max = pi/4;
    sideslip_max = pi/12;
    
    damping_sideslip = 0.25;
    bandwidth_sideslip = (G.a_beta2*(G.delta_r_max/sideslip_max)+G.a_beta1)/(2*damping_sideslip);
    
   
    G.k_p_sideslip = (G.delta_r_max/sideslip_max);
    G.k_i_sideslip = bandwidth_sideslip^2/abs(G.a_beta2);
    
    
     %% Pitch
    
    G.delta_e_max = pi/4;
    e_theta_max = pi/18;
    
    damping_pitch = 0.85;
  
    G.k_p_pitch = sign(G.a_theta3)*G.delta_e_max/e_theta_max;
    
    bandwidth_pitch = sqrt(G.a_theta2+G.k_p_pitch*G.a_theta3);
    
    G.k_d_pitch = (2*damping_pitch*bandwidth_pitch-G.a_theta1)/G.a_theta3;
    
    
end 

