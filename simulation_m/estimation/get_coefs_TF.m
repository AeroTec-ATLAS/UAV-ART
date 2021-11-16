% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - Pedro Martins
%          - Simão Caeiro

% Estimation of aerodynamic coefficients 

% Parameters
mass    = 3.228;       
rho     = 1.2682;
S_wing  = 0.38;      
b       = 1.60;     
c       = 0.24;     
g       = 9.8;
Ixx     = 0.229;       
Iyy     = 0.361;      
Izz     = 0.568;       
Ixz     = 0.029;      

% Engine parameters - Does not match the engine that was used
S_prop  = pi*(0.254/2)^2;    % Diameter: 10 in = 25.4 cm
k_motor = 39.955;          
C_prop  = 0.31385;     

% Computing angular accelerations 
[p_dot,q_dot,r_dot] = compute_acceleration([data.time],[data.p],[data.q],[data.r]);

% Computing aerodynamic forces and moments
[L,D,Y] = obter_forcas(data,alpha,mass,g,rho,S_prop,k_motor,C_prop);
[ell,m,n] = obter_momentos(data,Ixx,Iyy,Izz,Ixz,p_dot,q_dot,r_dot);

% Computing force coefficients and aerodynamic moments
C_L   = calc_C (rho,Va,S_wing,L,1);
C_D   = calc_C (rho,Va,S_wing,D,1);
C_Y   = calc_C (rho,Va,S_wing,Y,1);
C_ell = calc_C (rho,Va,S_wing,ell,b);
C_m   = calc_C (rho,Va,S_wing,m,c);
C_n   = calc_C (rho,Va,S_wing,n,b);

% Desired coefficients
Coef_L   = obter_coefs_long(C_L,data, c, alpha, delta_E);
Coef_D   = obter_coefs_long(C_D,data, c, alpha, delta_E);
Coef_Y   = obter_coefs_lat(C_Y, data, b, beta, delta_A);
Coef_ell = obter_coefs_lat(C_ell, data, b, beta, delta_A);
Coef_m   = obter_coefs_long(C_m,data, c, alpha, delta_E);
Coef_n   = obter_coefs_lat(C_n, data, b, beta, delta_A);

% Structure "C" containing the estimated coefficients 
C(1).C_L_0         = Coef_L(1);
C(1).C_L_alpha     = Coef_L(2);
% C(1).C_L_q         = Coef_L(3);
C(1).C_L_delta_e   = Coef_L(3);
C(1).C_D_0         = Coef_D(1);
C(1).C_D_alpha     = Coef_D(2);
% C(1).C_D_q         = Coef_D(3);
C(1).C_D_delta_e   = Coef_D(3);
C(1).C_m_0         = Coef_m(1);
C(1).C_m_alpha     = Coef_m(2);
% C(1).C_m_q         = Coef_m(3);
C(1).C_m_delta_e   = Coef_m(3);

C(1).C_Y_0         = Coef_Y(1);
C(1).C_Y_beta      = Coef_Y(2);
% C(1).C_Y_p         = Coef_Y(3);
% C(1).C_Y_r         = Coef_Y(4);
C(1).C_Y_delta_a   = Coef_Y(3);
% C(1).C_Y_delta_r   = Coef_Y(6);
C(1).C_ell_0       = Coef_ell(1);
C(1).C_ell_beta    = Coef_ell(2);
% C(1).C_ell_p       = Coef_ell(3);
% C(1).C_ell_r       = Coef_ell(4);
C(1).C_ell_delta_a = Coef_ell(3);
% C(1).C_ell_delta_r = Coef_ell(6);
C(1).C_n_0         = Coef_n(1);
C(1).C_n_beta      = Coef_n(2);
% C(1).C_n_p         = Coef_n(3);
% C(1).C_n_r         = Coef_n(4);
C(1).C_n_delta_a   = Coef_n(3);
% C(1).C_n_delta_r   = Coef_n(6);

% Regressive finite differences method (2nd order)
function [a_dot,b_dot,c_dot]=compute_acceleration(time,a,b,c)

for i = 3:length(time) % The first 2 elements are zero
    
    a_dot(i) = (3*a(i)-4*a(i-1)+a(i-2))/time(i)-time(i-1);
    b_dot(i) = (3*b(i)-4*b(i-1)+b(i-2))/time(i)-time(i-1);
    c_dot(i) = (3*c(i)-4*c(i-1)+c(i-2))/time(i)-time(i-1);
end

end



% Dimensioning of quantities
function C = calc_C (rho,Va,S_wing,FM,k)
for i=1:length(data)
     C(i)= FM(i)/ (0.5*rho*S_wing*((Va(i))^2)*k);  
end
end

% Computing aerodynamic forces: Lift(L), Drag(D), Lateral force(Y)
function [L,D,Y] = obter_forcas(data,alpha,mass,g,rho,S_prop,k_motor,C_prop)

for i=1:length(data)
    
X(i) = mass*(data(i).xacc - data(i).r*data(i).v + data(i).q*data(i).w + g*sin(data(i).theta));
    
Y(i) = mass*(data(i).yacc - data(i).p*data(i).w + data(i).r*data(i).u - g*cos(data(i).theta)*sin(data(i).phi));
    
Z(i) = mass*(data(i).zacc - data(i).q*data(i).u + data(i).p*data(i).v - g*cos(data(i).theta)*cos(data(i).phi));

% Subtract the propulsion force
X(i) = X(i) - 0.5*rho*S_prop*C_prop*((k_motor*delta_T(i))^2-(Va(i))^2);

% Rotate lift and drag forces from the stability frame to the body frame
R_sb = [cos(alpha(i))   -sin(alpha(i));...
        sin(alpha(i))   cos(alpha(i))];
 
F_matrix = inv(R_sb)*[X(i);Z(i)];
 
D(i) = - F_matrix(1);
L(i) = - F_matrix(2); 

end    

end

% Computing aerodynamic moments: x (ell), y (m), z (n)
function [ell,m,n] = obter_momentos(data,Ixx,Iyy,Izz,Ixz,p_dot,q_dot,r_dot)

for i=1:length(data)
    
ell(i) = Ixx*p_dot(i) - Ixz*(r_dot(i) + data(i).p*data(i).q) - (Iyy - Izz)*data(i).q*data(i).r;
    
m(i)   = Iyy*q_dot(i) - Ixz*(data(i).r^2 - data(i).p^2) - (Izz - Ixx)*data(i).r*data(i).p;
    
n(i)   = Izz*r_dot(i) - Ixz*(p_dot(i) - data(i).q*data(i).r) - (Ixx - Iyy)*data(i).p*data(i).q;
    
end    
end

% The Least Squares method
function Coef = NRLS(Y,X)
Coef = X*X'\X*Y';
end

% ch1 -> delta_a
% ch2 -> delta_e
% ch3 -> delta_t
% ch4 -> delta_r

% Longitudinal coefficients
function [Coef] = obter_coefs_long(C, data, c, alpha, delta_E)

for i=1:length(data) 
   Unit(i)= 1;
   % data_q_ad(i)= c*data(i).q / (2*data(i).Va); 
end

% X = [Unit(3:end);data(3:end).AoA;data_q_ad(3:end);data(3:end).RCch2];
X = [Unit(3:end);alpha(3:end);delta_E(3:end)];
Y = C(3:end);

Coef = NRLS(Y,X);

end

% Lateral coefficients
function [Coef] = obter_coefs_lat(C, data, b, beta, delta_A)

for i=1:length(data)  
   Unit(i)= 1; 
%    data_p_ad(i)= b*data(i).p / (2*data(i).Va); 
%    data_r_ad(i)= b*data(i).r / (2*data(i).Va); 
end

% X = [Unit(3:end);data(3:end).beta;data_p_ad(3:end);data_r_ad(3:end);data(3:end).RCch1;data(3:end).RCch4];
X = [Unit(3:end);beta(3:end);delta_A(3:end)];
Y = C(3:end);

Coef = NRLS(Y,X);

end
