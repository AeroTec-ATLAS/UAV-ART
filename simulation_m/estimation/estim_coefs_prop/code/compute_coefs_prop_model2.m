%rho - densidade do ar          
%D - diametro do propeller      
%Omega_p - velocidade angular do propeller 
%Va - Velociade da aeronave                
%Tp- magnitude da força de propulsao       
%Qp -magnitude do binario                  
%delta_t - comando de propolsao [0,1]      
%V_in  - tensao de entrada no motor        
%R é resistência dos enrolamentos do motor 
%i0 corrente que o motor puxa quando ta sem carga 
%K_Q - constante do motor                   
%K_V - constante do motor                   

rho=1.225; 

C_T = T_p *4*pi^2/(rho*D^4*Omega_p^2);
C_Q = Q_p *4*pi^2/(rho*D^5*Omega_p^2);

J = 2*pi*Va/(Omega_p*D);

C_T = C_T2*J^2 + C_T1*J + C_T0;
C_Q = C_Q2*J^2 + C_Q1*J + C_Q0;

%K_Q=K_V
Q_p = K_Q * (1/R * (V_in-K_V*Omega_p)-i0);
V_in = V_max * delta_t;

Phi = [J^2; J; 1];

coefs_T = NRLS(C_T,Phi);
coefs_Q = NRLS(C_Q,Phi);

function Coef = NRLS(Y,Phi)
Coef = (Phi'*Phi)^(-1) * Phi'*Y;
end


