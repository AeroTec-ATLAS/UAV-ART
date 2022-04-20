function [x_dot] = finite_differences(x)

h = 0.01; %sampling period 

%Regressive finite differences - 2nd order
for i=3:length(x)
    x_dot(i) = (3*x(i)-4*x(i-1)+x(i-2))/(2*h);
end

end