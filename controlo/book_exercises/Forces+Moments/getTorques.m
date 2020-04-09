function T_vec = getTorques(Va,alpha,q,de,beta,p,r,da,dr,P)

    L = P.b*(P.C_l0 + P.C_lb*beta + P.C_lp*(P.b/(2*Va))*p + ...
                        P.C_lr*(P.b/(2*Va))*r + P.C_lda*da + P.C_ldr*dr);
        
    M = P.c*(P.C_m0 + P.C_ma*alpha + P.C_mq*(P.c/(2*Va))*q + P.C_mde*de);
    
    N = P.b*(P.C_n0 + P.C_nb*beta + P.C_np*(P.b/(2*Va))*p + ...
                        P.C_nr*(P.b/(2*Va))*r + P.C_nda*da + P.C_ndr*dr);
                    
    T_vec = 0.5*P.rho*Va^2*P.S*[L;M;N];    
end

