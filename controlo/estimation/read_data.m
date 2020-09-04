%Programa que lê os dados do ficheiro ".txt" para a 
%structures array "data".

%2020-05-21_23.07.txt - log que inclui apenas a parte longitudinal
%dados_log3crudder.txt - log que inclui longitudinal + lateral

% fid = fopen('2020-05-21_23.07.txt','rt');
fid = fopen('dados_log3crudder.txt','rt');

if fid < 0
    disp('Erro na abertura do ficheiro ".txt"');
else
    i = -1;
    while ~feof(fid)
        line = fgetl(fid);
        i = i + 1;             
        if  i > 0
            [value, remain]  =  strtok(line);
            data(i).time     =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).theta    =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).psi      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).phi      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).q        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).r        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).p        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).lat      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).long     =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).alt      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).u        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).v        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).w        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).Va       =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).AoA      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).beta     =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).RCch1    =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).RCch2    =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).RCch3    =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).RCch4    =  str2num(value);

%Forças e momentos aerodinâmicos (não são utilizados)

            [value, remain]  =  strtok(remain);
            data(i).F_D      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).F_Y      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).F_L      =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).fx       =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).fy       =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).fz       =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).l_aero   =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).m_aero   =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).n_aero   =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).l        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).m        =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).n        =  str2num(value);
        end
    end
end

fclose(fid);