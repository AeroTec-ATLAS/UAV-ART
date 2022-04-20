function [C] = compute_coefficients(F, rho, S, Va, x)

for i=1:length(Va)
C = F/(0.5*rho*Va(i)^2*S*x);
end

end