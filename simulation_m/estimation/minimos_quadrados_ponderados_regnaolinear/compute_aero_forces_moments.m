function [aero_fm] = compute_aero_forces_moments(Coeff, rho, S, Va, x)

for i=1:length(Va)
 aero_fm = Coeff*0.5*rho*Va(i)^2*S*x;
end

end