function P = getGains(P,G)
    %% Roll gains
    
    G.delta_a_max = pi/9;
    e_phi_max = pi/12;
    
    G.k_p_roll = 1;
 
    bandwidth_roll = sqrt(abs(G.a_phi2)*G.k_p_roll);
    damping_roll = 1.4;
    
    G.k_d_roll = (2*damping_roll*bandwidth_roll-G.a_phi1)/G.a_phi2;
    

    
%     s = tf('s');
%     tf_roll = G.a_phi2/(s*(s^2 + (G.a_phi1 + G.a_phi2*G.k_d_roll)*s + ...
%               G.a_phi2*G.k_p_roll));
%           
%     rlocus(tf_roll);
%     
%     
%     %G.k_i_roll = 0.6;
    G.k_i_roll = 0.4;
    
   
    %% Course angle
    
    bandwidth_course = bandwidth_roll/25;
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
    
    G.delta_e_max = pi/6;
    e_theta_max = pi/18;
    
    damping_pitch = 0.85;
  
    G.k_p_pitch = sign(G.a_theta3)*G.delta_e_max/e_theta_max;
    
    bandwidth_pitch = sqrt(G.a_theta2+G.k_p_pitch*G.a_theta3);
    
    G.k_d_pitch = (2*damping_pitch*bandwidth_pitch-G.a_theta1)/G.a_theta3;
    
    k_theta_DC = G.k_p_pitch*G.a_theta3/(G.a_theta2+G.k_p_pitch*G.a_theta3);
    
    %% Altitude from pitch
    
    bandwidth_altitude_pitch = bandwidth_pitch/38;
 
    damping_altitude_pitch = 2;
    
    G.k_i_pitch_altitude = bandwidth_altitude_pitch^2/(k_theta_DC*G.Va_trim);
    G.k_p_pitch_altitude = 2*damping_altitude_pitch*bandwidth_altitude_pitch/(k_theta_DC*G.Va_trim);
    
     %% Airspedd from pitch
    
    bandwidth_airspeed_pitch = bandwidth_pitch/11;
    
    damping_airspeed_pitch = 1.6;
    
    G.k_p_pitch_airspeed = (G.a_V1-2*damping_airspeed_pitch*bandwidth_airspeed_pitch)/(k_theta_DC*P.gravity);
    G.k_i_pitch_airspeed = -bandwidth_airspeed_pitch^2/(k_theta_DC*P.gravity);
    
    
    %% Airspedd from throttle
    
    bandwidth_airspeed_throttle = 0.2;
    damping_airspeed_throttle = 1.4;
    
    G.k_p_throttle_airspeed = (-G.a_V1+2*damping_airspeed_throttle*bandwidth_airspeed_throttle)/(G.a_V2);
    G.k_i_throttle_airspeed = bandwidth_airspeed_throttle^2/(G.a_V2);
    
    %G.k_p_throttle_airspeed = 0;
    %G.k_i_throttle_airspeed = 0;
     %% Save in struct P
    
    P.G = G;
    

    
end 

