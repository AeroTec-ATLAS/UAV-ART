function [fx, fy, fz] = external_forces (m, u_dot, v_dot, w_dot, data)

for i=1:length(data)
    fx(i) = m*( u_dot(i) - data(i).r*data(i).v + data(i).q*data(i).w );
    fy(i) = m*( v_dot(i) - data(i).p*data(i).w + data(i).r*data(i).u );
    fz(i) = m*( w_dot(i) - data(i).q*data(i).u + data(i).p*data(i).v );
end

end