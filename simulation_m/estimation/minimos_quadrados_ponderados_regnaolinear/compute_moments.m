function [l, m, n] = compute_moments(Ixx, Iyy, Izz, Ixz, p_dot, q_dot, r_dot, data)

%Inertia matrix J
J = [Ixx 0 -Ixz;
     0 Iyy 0;
     -Ixz 0 Izz];
 
for i = 1:length(data)
    
%Matrix A 
A(:,i) = J*([p_dot(i); q_dot(i); r_dot(i)]);

%Matrix B = cross_product(-w, Jw)
B(:,i) = [ Ixz*(data(i).p*data(i).q) + (Iyy - Izz)*data(i).q*data(i).r ;
      Ixz*(data(i).r^2 - data(i).q^2) + (Izz-Ixx)*data(i).p*data(i).r;
     (Ixx - Iyy)*data(i).p*data(i).q - Ixz*data(i).q*data(i).r ];
     
%Compute roll, pitch and yaw moments
matrix_M = A - B;
l(i) = matrix_M(1,i);
m(i) = matrix_M(2,i);
n(i) = matrix_M(3,i);

end
     
end
