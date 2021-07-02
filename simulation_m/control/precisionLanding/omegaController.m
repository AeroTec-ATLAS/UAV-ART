% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Angular velocity controller

load("trim/params.mat")
% Equation 48 [1]
Maabb = [P.C_ell_beta 0; 0 P.C_m_alpha; P.C_n_beta 0];

Vbar = 10; % this corresponds to V bar but I do not know what this is
Moo = [P.b*P.C_ell_p,0,0;
            0,P.c*P.C_m_q,0;
            P.b*P.C_n_p,0,P.b*P.C_n_r];
Moo = Moo/(2*V);

Mdd = [0,P.C_ell_delta_a,P.C_ell_delta_r;
        P.C_m_delta_e,0,0;
        0,P.C_n_delta_a,P.C_n_delta_r];
    
alpha0 = 0.01; % corresponds to the angle of attack that nullifies the 
                % resulting forces due to the drag, lift and gravity. see
                % paper and try to calculate this value for our model
                
% [1] Serra, Pedro & Cunha, Rita & Hamel, T. & Silvestre, Carlos & Le Bras, Florent. (2015). Nonlinear Image-Based Visual Servo Controller for the Flare Maneuver of Fixed-Wing Aircraft Using Optical Flow. IEEE Transactions on Control Systems Technology. 23. 570–583. 10.1109/TCST.2014.2330996. 