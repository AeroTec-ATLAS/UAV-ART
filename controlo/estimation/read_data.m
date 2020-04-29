%Programa que lê os dados do ficheiro "dados_log.txt" para a 
%structures array "data".

fid = fopen('dados_1.txt','rt');

if fid < 0
    disp('Erro na abertura do ficheiro "dados_log.txt"');
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
            data(i).pn       =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).pe       =  str2num(value);
            [value, remain]  =  strtok(remain);
            data(i).h        =  str2num(value);
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
        end
    end
end

fclose(fid);