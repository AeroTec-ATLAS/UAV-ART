function [pdot,qdot,rdot] = getAngularRateDerivatives(p,q,r,l,m,n)

    S = evalin('base','S');
    
    pdot = S.g1*p*q - S.g2*q*r + S.g3*l + S.g4*n;
    qdot = S.g5*p*r - S.g6*(p^2-r^2) + m/S.Jy;
    rdot = S.g7*p*q - S.g1*q*r + S.g4*l + S.g8*n;
    
end

