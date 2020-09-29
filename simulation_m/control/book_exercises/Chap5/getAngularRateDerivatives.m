function [pdot,qdot,rdot] = getAngularRateDerivatives(p,q,r,l,m,n,P)
    
    pdot = P.g1*p*q - P.g2*q*r + P.g3*l + P.g4*n;
    qdot = P.g5*p*r - P.g6*(p^2-r^2) + m/P.Jy;
    rdot = P.g7*p*q - P.g1*q*r + P.g4*l + P.g8*n;
    
end

