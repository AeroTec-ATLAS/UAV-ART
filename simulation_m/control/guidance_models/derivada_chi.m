% Diferenças finitas regressivas

function [a_dot]=derivada_chi(time,a)


persistent t0;
persistent aux_0;


if time==0
    t0=time;
    aux_0=a;
    a_dot=0;
else
    t1=time;
    intervalo_tempo= t1-t0;
    aux_1=a;   
    
    if intervalo_tempo ==0
        a_dot=0;
    else
        a_dot= (aux_1-aux_0)/intervalo_tempo;
    end
    aux_0=a;
    t0=time;
end
end

