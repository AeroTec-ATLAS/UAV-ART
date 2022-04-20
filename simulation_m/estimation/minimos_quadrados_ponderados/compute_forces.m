function [F_Lift, Fy, F_Drag] = compute_forces(m, g, rho, S_prop, k_motor, C_prop, data, fx, fy, fz)

for i=1:length(data)

%Gravitational force in body frame 
fg = [-m*g*sin(data(i).theta); m*g*cos(data(i).theta)*sin(data(i).phi); m*g*cos(data(i).theta)*cos(data(i).phi)];

%Propulsion force
fp = 0.5*rho*S_prop*C_prop*[(k_motor*data(i).RCch3)^2-data(i).Va^2; 0; 0];

%Aerodynamic forces
fx_aero(i) = fx(i) - fg(1) - fp(1);
fz_aero(i) = fz(i) - fg(3);
    
    
%Rotation matrix from stability to body frame
Rsb = [ cos(data(i).AoA) -sin(data(i).AoA) ; sin(data(i).AoA) cos(data(i).AoA)];

%Compute lift and drag forces
matrix_F = -inv(Rsb)*[fx_aero(i);fz_aero(i)];
F_Drag(i) = matrix_F(1);
F_Lift(i) = matrix_F(2);

%Compute lateral force
Fy(i) = fy(i) - fg(2);

end

end
