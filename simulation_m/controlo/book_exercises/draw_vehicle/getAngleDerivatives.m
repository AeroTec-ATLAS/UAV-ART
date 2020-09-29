function v_out = getAngleDerivatives(phi,theta,p,q,r)

    Q = [1 sin(phi)*tan(theta) cos(phi)*tan(theta); ...
         0 cos(phi) -sin(phi); ...
         0 sin(phi)/cos(theta) cos(phi)/cos(theta)];
     
    v = [p q r];
    v_out = v*Q';

end

