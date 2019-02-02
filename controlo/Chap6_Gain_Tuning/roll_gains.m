
 G.k_p_roll = 3;
 
    bandwidth_roll = sqrt(abs(G.a_phi2)*G.k_p_roll);
    damping_roll = 0.8;
    
    G.k_d_roll = (2*damping_roll*bandwidth_roll-G.a_phi1)/G.a_phi2;
    
    
    % Root Locus
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
    
    %G.k_i_roll = 0.6;
    G.k_i_roll = 0;
    
     sim('roll_loop', 10);
    figure;
    plot(roll_Out);
    figure;
    plot(delta_a);
    
    