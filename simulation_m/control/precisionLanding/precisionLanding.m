% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Inner Loop

clearvars -except alpha beta
load("params.mat")

%% Airspeed controller

g = P.gravity;

%controller gains
k_VP = 0.5; %arbitrary value
k_VI = 0.8; %arbitrary value

%epsilon = [x y z]'; 
%d = -eta'*epsilon;
d = 20;

gama = 1;

k1 = 1;
k2 = 0.5;
k3 = 5;
k4 = 3.5;

D = diag([0 k1*k3 k4/d]);

%% Angular velocity controller

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
                
% [1] Serra, Pedro & Cunha, Rita & Hamel, T. & Silvestre, Carlos & Le Bras,
%Florent. (2015). Nonlinear Image-Based Visual Servo Controller for the 
%Flare Maneuver of Fixed-Wing Aircraft Using Optical Flow. IEEE 
%Transactions on Control Systems Technology. 23. 570–583. 10.1109/TCST.2014.2330996.

%% Attitude controller

G=[sin(alpha) 0 -cos(alpha);-cos(alpha)*tan(beta) 1 -sin(alpha)*tan(beta);...
    cos(alpha)/cos(beta) 0 sin(alpha)/cos(beta)];

W=[W1;W2;W3];

W1=-D*tan(beta)-C+mass*g*(sin(miu)*cos(gamma)-sin(gamma)*tan(beta));

W2=(-D*tan(alpha)-L*cos(beta)+mass*g*(cos(miu)*cos(gamma)*cos(beta)-...
    sin(gamma)*tan(alpha)))/((cos(beta))^2);

W3=L*(tan(beta)+tan(gamma)*sin(miu))-C*tan(gamma)*cos(miu)+D*...
    (((tan(alpha)*sin(miu)*tan(gamma)+tan(alpha)*tan(beta))/(cos(beta)))...
    -tan(beta)*cos(miu)*tan(gamma))+mass*g*(((tan(alpha)*sin(miu)*tan...
    (gamma)*sin(gamma)+tan(alpha)*tan(beta)*sin(gamma))/(cos(beta)))-...
    ((tan(beta)*cos(miu))/cos(gamma)));

