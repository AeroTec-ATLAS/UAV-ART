function [X] = lat_variables_matrix(data, b)

for i=1:length(data)
    r_nondim(i) = data(i).r*b/(2*data(i).Va);
    p_nondim(i) = data(i).p*b/(2*data(i).Va);
end

%X= [ones(length(data),1) [data.beta]' p_nondim' r_nondim' [data.RCch1]' [data.RCch4]'];

%For the simplified model
X= [ones(length(data),1) [data.beta]' [data.RCch1]'];

end