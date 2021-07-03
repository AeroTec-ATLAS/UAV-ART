clc
clear
close all

%% escolher ficheiro
% propeller: prop10x5 ou prop11x7
% ps(fonte de tensao): 12(V), 16(V) ou bat(bateria):3s ou 4s
% velocidade do ar: 6, 10, 15 ou 20 (m/s)

name = 'test_prop10x5_ps12_v10';

struct = load(name);
fn = fieldnames(struct);
data_struct = struct.(fn{1});

%% variaveis
index = find([data_struct.delta_t]==100,1,'last'); %rejeitar efeito de histerese

time = [data_struct(1:index).time]; % segundos
delta_t = [data_struct(1:index).delta_t]; % percentagem
I = [data_struct(1:index).I]; % A
V = [data_struct(1:index).V]; % V
Va = [data_struct(1:index).Va]; % m/s
rpm = [data_struct(1:index).rpm]; % rpm
load_cell = [data_struct(1:index).load_cell]; % kg

g = 9.80031; %aceleracao gravitica no lab de aero


%% Figuras
% figure()
% plot(delta_t, load_cell);
% 
% figure()
% plot(delta_t, I);
% 
% figure()
% plot(delta_t, V);

%% tratamento de dados

% Os valores de delta_t retirados nao estavam calibrados. Tal como se pode
% observar nas figuras anteriores, o motor apenas comeca a trabalhar a
% partir do delta_t= 14% e satura em delta_t=70%. Como tal, decidiu-se
% reformular a escala do delta_t, considerando-se os valores mencionados
% como o 0 e o 100%, respetivamente. Para os valores entre os limites
% verificados, decidiu-se utilizar uma escala linear.

delta_t_corrected = zeros(1,length(delta_t));

for i=1:length(delta_t)   
    if (delta_t(i) > 70)
        delta_t_corrected(i) = 100;
        index_sup = i;
    elseif (delta_t(i) < 13)
        delta_t_corrected(i) = 0;
        index_inf = i;
    else
        delta_t_corrected(i) = (delta_t(i)-13)*100/57;
    end 
end

%retirar bias da corrente
bias_current = mean(I(1:index_inf)); %enquanto o delta_t=0
I = I - bias_current;

%desprezar rpm enquanto delta_t=0
rpm(1:index_inf) = 0;

%retirar drag da estrutura
load('test_drag.mat');

Va_mean = mean(Va);

%considerar incerteza de +- 0.5m/s
lim_inf = Va_mean - 0.5; 
lim_sup = Va_mean + 0.5;

i_lim_inf = find([test_drag.Va] < lim_inf, 1, 'last');
i_lim_sup = find([test_drag.Va] < lim_sup, 1, 'last');

loadcell_d_mean = mean([test_drag(i_lim_inf:i_lim_sup).load_cell_drag]);

load_cell_corrected = load_cell - loadcell_d_mean;

%% conversao de unidades
T = load_cell_corrected.*g;
DeltaT = delta_t_corrected/100;

%% guardar dados processados
save("Ficheiros_processados/ProcessedData_"+name+".mat","time","DeltaT",...
        "T","Va","I","V","rpm");

