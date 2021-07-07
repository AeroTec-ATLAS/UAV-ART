% brief Estimates the motor coefficients according to a simple model
% param D_prop Diameter of the propeller in meter
% param f_prop Thrust force in each experiment in N
% param delta_t Thrust command normalized between 0 and 1
% param Va Airspeed in m/s
% return C_prop and k_motor which are coefficients for the model
function [C_prop,k_motor] = compute_coefs_prop_model3(D_prop,f_prop,delta_t,Va)
    rho = 1.225;                % air density in kg/m^3
    S_prop = pi * (D_prop/2)^2; % propeller area in m^2

    % least-squares model as ||Ax-b||^2
    b = 2/(rho*S_prop)*f_prop;
    A = [delta_t.^2,-Va.^2];
    x = (A'*A)\(A'*b);

    C_prop = x(2);
    k_motor = sqrt(x(1)/x(2));
end