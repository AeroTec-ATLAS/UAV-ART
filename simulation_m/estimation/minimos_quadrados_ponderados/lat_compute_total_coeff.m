function [C_total] = lat_compute_total_coeff(C_coeffs, data, b)

for i=1:length(data)
    r_nondim(i) = data(i).r*b/(2*data(i).Va);
    p_nondim(i) = data(i).p*b/(2*data(i).Va);
end


for i=1:length(data)
%C_total(i) = C_coeffs(1) + C_coeffs(2)*data(i).beta + C_coeffs(3)*p_nondim(i) + C_coeffs(4)*r_nondim(i) + C_coeffs(5)*data(i).RCch1 + C_coeffs(6)*data(i).RCch4 ;  

%For the simplified model
C_total(i) = C_coeffs(1) + C_coeffs(2)*data(i).beta + C_coeffs(3)*data(i).RCch1;  

end

end