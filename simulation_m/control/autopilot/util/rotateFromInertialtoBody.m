function v_out = rotateFromInertialtoBody(phi,theta,psi,v1,v2,v3)
    
    r11 = cos(theta)*cos(psi);
    r12 = cos(theta)*sin(psi);
    r13 = -sin(theta);
    r21 = sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi);
    r22 = sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi);
    r23 = sin(phi)*cos(theta);
    r31 = cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi);
    r32 = cos(phi)*sin(theta)*cos(psi) - sin(phi)*cos(psi);
    r33 = cos(phi)*cos(theta);
    
    R = [r11 r12 r13;r21 r22 r23;r31 r32 r33];
    v = [v1 v2 v3];
    
    v_out = v*R';   
end

