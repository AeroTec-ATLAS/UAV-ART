close all

t_s = 5;

data = cat(2,ones(1,25),zeros(1,26));
Fx = timeseries(data,0:0.1:t_s);
Gx = 1;

figure(99)
plot(Fx.Time,squeeze(Fx.Data),'LineWidth',1.5)
hold on
grid minor
title('Force applied along the body x-axis','Interpreter','Latex',...
        'FontSize',16);
xlabel('Time (s)','Interpreter','Latex','FontSize',16);
ylabel('Force (N)','Interpreter','Latex','FontSize',16);

sim('mavsim_chap3.slx',t_s);

figure(98)
plot(pn.Time,squeeze(pn.Data),'LineWidth',1.5,'Color','r')
hold on
grid minor
title('Inertial North Position $$p_n$$','Interpreter','Latex',...
        'FontSize',16);
xlabel('Time (s)','Interpreter','Latex','FontSize',16);
ylabel('x (m)','Interpreter','Latex','FontSize',16);