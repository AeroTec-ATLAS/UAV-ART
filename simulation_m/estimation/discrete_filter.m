clc
close all

%% IAS filtering

IAS_n = 100; % Filter parameter: change
data_filtered_IAS(1) = data(1).IAS;
for i = 2:length(data)
    data_filtered_IAS(i) = (IAS_n - 1)/IAS_n*data_filtered_IAS(i-1) + 1/IAS_n*data(i).IAS;
end

figure
plot([data.time],[data.IAS],'LineWidth',1.5)
hold on
plot([data.time],data_filtered_IAS,'LineWidth',1.5)
title('Discrete time filter')
xlabel('time [s]')
ylabel('IAS [m/s]')
legend('original','filtered')


%% roll angle filtering

phi_n = 150; % Filter parameter: change
data_filtered_phi(1) = data(1).phi;
for i = 2:length(data)
    data_filtered_phi(i) = (phi_n - 1)/phi_n*data_filtered_phi(i-1) + 1/phi_n*data(i).phi;
end

figure
plot([data.time],[data.phi],'LineWidth',1.5)
hold on
plot([data.time],data_filtered_phi,'LineWidth',1.5)
title('Discrete time filter')
xlabel('time [s]')
ylabel('Roll angle [rad]')
legend('original','filtered')

