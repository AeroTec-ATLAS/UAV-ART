function F_vec = getFAer(Va,alpha,q,de,beta,p,r,da,dr,P)
    
    F_lift = P.C_L0 + P.C_La*alpha + P.C_Lq*(P.c/(2*Va))*q + P.C_Lde*de;
                                    
    F_drag = P.C_D0 + P.C_Da*alpha + P.C_Dq*(P.c/(2*Va))*q + P.C_Dde*de;
                                
    Fy = P.C_Y0 + P.C_Yb*beta + P.C_Yp*(P.b/(2*Va))*p + ... 
                        P.C_Yr*(P.b/(2*Va))*r + P.C_Yda*da + P.C_Ydr*dr;
    
    % Rotate lift and drag forces from the stability frame to body frame
    R = [cos(alpha)   -sin(alpha);...
        sin(alpha)   cos(alpha)];  
    
    F_body = R*[-F_drag;-F_lift];            
    F_vec = 0.5*P.rho*Va^2*P.S*[F_body(1);Fy;F_body(2)];

end

