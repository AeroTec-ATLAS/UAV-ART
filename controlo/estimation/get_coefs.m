%Programa para a obtenção de coeficientes aerodinâmicos

%Parametros físicos
m       = 25;
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


%Obter as acelerações lineares e angulares 
[u_dot,v_dot,w_dot] = compute_acceleration([data.time],[data.u],[data.v],[data.w]);
[p_dot,q_dot,r_dot] = compute_acceleration([data.time],[data.p],[data.q],[data.r]);

%Obter as forças aerodinâmicas
[L,D,Y] = obter_forcas(data,m,g,rho,S_prop,k_motor,C_prop,u_dot,v_dot,w_dot);

%Obter os momentos aerodinâmicos
[ell,m,n] = obter_momentos(data,Ixx,Iyy,Izz,Ixz,p_dot,q_dot,r_dot);

%Cálculo dos coeficientes das forças e momentos aerodinâmicos
C_L   = calc_C (rho,data,S_wing,L,1);
C_D   = calc_C (rho,data,S_wing,D,1);
C_Y   = calc_C (rho,data,S_wing,Y,1);
C_ell = calc_C (rho,data,S_wing,ell,b);
C_m   = calc_C (rho,data,S_wing,m,c);
C_n   = calc_C (rho,data,S_wing,n,b);

%Coeficientes pretendidos
Coef_L   = obter_coefs_long(C_L,data);
Coef_D   = obter_coefs_long(C_D,data);
Coef_Y   = obter_coefs_lat(C_Y, data);
Coef_ell = obter_coefs_lat(C_ell, data);
Coef_m   = obter_coefs_long(C_m,data);
Coef_n   = obter_coefs_lat(C_n, data);

%Estrutura com os coeficientes: Estrutura C

C.C_L_0         = Coef_L(1);
C.C_L_alpha     = Coef_L(2);
C.C_L_q         = Coef_L(3);
C.C_L_delta_e   = Coef_L(4);
C.C_D_0         = Coef_D(1);
C.C_D_alpha     = Coef_D(2);
C.C_D_q         = Coef_D(3);
C.C_D_delta_e   = Coef_D(4);
C.C_m_0         = Coef_m(1);
C.C_m_alpha     = Coef_m(2);
C.C_m_q         = Coef_m(3);
C.C_m_delta_e   = Coef_m(4);
C.C_Y_0         = Coef_Y(1);
C.C_Y_beta      = Coef_Y(2);
C.C_Y_p         = Coef_Y(3);
C.C_Y_r         = Coef_Y(4);
C.C_Y_delta_a   = Coef_Y(5);
C.C_Y_delta_r   = Coef_Y(6);
C.C_ell_0       = Coef_ell(1);
C.C_ell_beta    = Coef_ell(2);
C.C_ell_p       = Coef_ell(3);
C.C_ell_r       = Coef_ell(4);
C.C_ell_delta_a = Coef_ell(5);
C.C_ell_delta_r = Coef_ell(6);
C.C_n_0         = Coef_n(1);
C.C_n_beta      = Coef_n(2);
C.C_n_p         = Coef_n(3);
C.C_n_r         = Coef_n(4);
C.C_n_delta_a   = Coef_n(5);
C.C_n_delta_r   = Coef_n(6);


% Diferenças finitas regressivas
function [a_dot,b_dot,c_dot]=compute_acceleration(time,a,b,c)

for i = 2:length(time) %O primeiro elemento será nulo
    %a_dot(i) = (a(i)-a(i-1))/(time(i)-time(i-1));
    %b_dot(i) = (b(i)-b(i-1))/(time(i)-time(i-1));
    %c_dot(i) = (c(i)-c(i-1))/(time(i)-time(i-1));
    a_dot(i) = (a(i)-a(i-1))/0.01;
    b_dot(i) = (b(i)-b(i-1))/0.01;
    c_dot(i) = (c(i)-c(i-1))/0.01;
end

end

% Adimensionalização das grandezas
function C = calc_C (rho,data,S_wing,FM,k)
for i=1:length(data)
     C(i)= FM(i)/ (0.5*rho*S_wing*((data(i).Va)^2)*k);  
end
end

%Obter L,D,Y
function [L,D,Y] = obter_forcas(data,m,g,rho,S_prop,k_motor,C_prop,u_dot,v_dot,w_dot)

for i=1:length(data)
    
X(i) = m*(u_dot(i) - data(i).r*data(i).v + data(i).q*data(i).w + g*sin(data(i).theta));
    
Y(i) = m*(v_dot(i) - data(i).p*data(i).w + data(i).r*data(i).u - g*cos(data(i).theta)*sin(data(i).phi));
    
Z(i) = m*(w_dot(i) - data(i).q*data(i).u + data(i).p*data(i).v - g*cos(data(i).theta)*cos(data(i).phi));

%Descontar a força de propulsão
X(i) = X(i) - 0.5*rho*S_prop*C_prop*((k_motor*data(i).RCch3)^2-data(i).Va^2);

% Rotate lift and drag forces from the stability frame to the body frame
R_sb = [cos(data(i).AoA)   -sin(data(i).AoA);...
        sin(data(i).AoA)   cos(data(i).AoA)];
 
F_matrix = inv(R_sb)*[X(i);Z(i)];
 
L(i) = - F_matrix(1);
D(i) = - F_matrix(2); 

end    
end

%Obter ell,m,n
function [ell,m,n] = obter_momentos(data,Ixx,Iyy,Izz,Ixz,p_dot,q_dot,r_dot)

for i=1:length(data)
    
ell(i) = Ixx*p_dot(i) - Ixz*(r_dot(i) + data(i).p*data(i).q) - (Iyy - Izz)*data(i).q*data(i).r;
    
m(i)   = Iyy*q_dot(i) - Ixz*(data(i).r^2 - data(i).p^2) - (Izz - Ixx)*data(i).r*data(i).p;
    
n(i)   = Izz*r_dot(i) - Ixz*(p_dot(i) - data(i).q*data(i).r) - (Ixx - Iyy)*data(i).p*data(i).q;
    
end    

end

% Mínimos quadrados

function Coef = NRLS(Y,X)
Coef = inv(X*X')*X*Y';
end

%ch1 -> delta_a
%ch2 -> delta_e
%ch3 -> delta_t
%ch4 -> delta_r

%Obter coeficientes longitudinais
function [Coef] = obter_coefs_long(C, data)

for i=1:length(data)    
   Unit(i)= 1;     
end

X = [Unit;data.AoA;data.q;data.RCch2];
Y = [C];

Coef = NRLS(Y,X);

end
%Obter coeficientes laterais
function [Coef] = obter_coefs_lat(C, data)

for i=1:length(data)    
   Unit(i)= 1;    
end

X = [Unit;data.beta;data.p;data.r;data.RCch1;data.RCch4];
Y = [C];

Coef = NRLS(Y,X);

end
