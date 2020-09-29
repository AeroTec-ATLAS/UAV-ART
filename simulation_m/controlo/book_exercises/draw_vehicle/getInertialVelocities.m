function v_out = getInertialVelocities(phi,theta,psi,u,v,w)

    r11 = cos(theta)*cos(psi);
    r12 = sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi);
    r13 = cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi);
    r21 = cos(theta)*sin(psi);
    r22 = sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi);
    r23 = cos(phi)*sin(theta)*cos(psi) - sin(phi)*cos(psi);
    r31 = -sin(theta);
    r32 = sin(phi)*cos(theta);
    r33 = cos(phi)*cos(theta);
    
    R = [r11 r12 r13;r21 r22 r23;r31 r32 r33];
    v = [u v w];
    
    v_out = v*R';
end

