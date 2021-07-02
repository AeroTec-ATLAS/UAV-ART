% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Airspeed controller

%variables for airspeed controller
mass = 25;
g = 9.8;

%controller gains
k_VP = 0.5; %arbitrary value
k_VI = 0.8; %arbitrary value

%%%%epsilon = [x y z]'; 
%d = -eta'*epsilon;
d = 20;

gama = 1;

k1 = 1;
k2 = 0.5;
k3 = 5;
k4 = 3.5;

D = diag([0 k1*k3 k4/d]);