function [X] = long_variables_matrix(data, c)

for i=1:length(data)
    q_nondim(i) = data(i).q*c/(2*data(i).Va);
end

%Variables matrix 
%For the complete model 
%X = [ ones(length(data),1) [data.AoA]' q_nondim' [data.RCch2]'];

%X = [ ones(length(data),1) [data.AoA]' [data.q]' [data.RCch2]'];

%For the simplified model 
X = [ ones(length(data),1) [data.AoA]' [data.RCch2]'];

end