function [C_total] = long_compute_total_coeff(C_coeffs, data, c)

for i=1:length(data)
    q_nondim(i) = data(i).q*c/(2*data(i).Va);
end

for i=1:length(data)
C_total(i) = C_coeffs(1) + C_coeffs(2)*data(i).AoA + C_coeffs(3)*q_nondim(i) + C_coeffs(4)*data(i).RCch2;  

%For the simplified model
%C_total(i) = C_coeffs(1) + C_coeffs(2)*data(i).AoA + C_coeffs(3)*data(i).RCch2;  

end

end