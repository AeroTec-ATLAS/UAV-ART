close all

figure
subplot(3,1,1)
plot(t,pos(:,1),'Linewidth',1.5)
ylabel('North [m]')
hold on
title('Inertial Position','Fontsize',11)
grid on

subplot(3,1,2)
plot(t,pos(:,2),'Linewidth',1.5)
ylabel('East [m]')
hold on
grid on

subplot(3,1,3)
plot(t,-pos(:,3),t,h_ref,'Linewidth',1.5) 
ylabel('Altitude [m]')
xlabel('Time [s]')
legend('Observed','Reference','Location','best')
hold on
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(t,Va,t,Va_ref,'Linewidth',1.5)
ylabel('V_a [m/s]')
xlabel('Time [s]')
hold on
title('Airspeed','Fontsize',11)
legend('Observed','Reference','Location','best')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(t,180/pi*chi,t,180/pi*chi_ref,'Linewidth',1.5)
ylabel('\chi [deg]')
xlabel('Time [s]')
hold on
title('Course Angle','Fontsize',11)
legend('Observed','Reference','Location','best')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(3,1,1)
plot(t,v(:,1),'Linewidth',1.5)
ylabel('u [m/s]')
hold on
title('Body frame linear velocity','Fontsize',11)
grid on

subplot(3,1,2)
plot(t,v(:,2),'Linewidth',1.5)
ylabel('v [m/s]')
hold on
grid on

subplot(3,1,3)
plot(t,v(:,3),'Linewidth',1.5) 
ylabel('w [m/s]')
xlabel('Time [s]')
hold on
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(3,1,1)
plot(t,att(:,1)*180/pi,t,roll_ref*180/pi,'Linewidth',1.5)
ylabel('\phi [deg]')
hold on
title('Aircraft Attitude','Fontsize',11)
grid on

subplot(3,1,2)
plot(t,att(:,2)*180/pi,t,theta_ref*180/pi,'Linewidth',1.5)
ylabel('\theta [deg]')
legend('Observed','Reference','Location','best')
hold on
grid on

subplot(3,1,3)
plot(t,att(:,3)*180/pi,'Linewidth',1.5) 
ylabel('\psi [deg]')
xlabel('Time [s]')
hold on
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(3,1,1)
plot(t,ang_v(:,1),'Linewidth',1.5)
ylabel('p [rad/s]')
hold on
title('Body frame angular velocity','Fontsize',11)
grid on

subplot(3,1,2)
plot(t,ang_v(:,2),'Linewidth',1.5)
ylabel('q [rad/s]')
hold on
grid on

subplot(3,1,3)
plot(t,ang_v(:,3),'Linewidth',1.5) 
ylabel('r [rad/s]')
xlabel('Time [s]')
hold on
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(2,1,1)
plot(t,alpha*180/pi,'Linewidth',1.5)
ylabel('\alpha [deg]')
hold on
title('Aerodynamic Angles','Fontsize',11)
grid on

subplot(2,1,2)
plot(t,beta*180/pi,'Linewidth',1.5)
ylabel('\beta [deg]')
xlabel('Time [s]')
hold on
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(3,1,1)
plot(t,180/pi*delta(:,1),'Linewidth',1.5)
ylabel('\delta_e [deg]')
hold on
title('Control surfaces','Fontsize',11)
grid on

subplot(3,1,2)
plot(t,180/pi*delta(:,2),'Linewidth',1.5)
ylabel('\delta_a [deg]')
hold on
grid on

subplot(3,1,3)
plot(t,delta(:,4),'Linewidth',1.5)
ylabel('\delta_t')
xlabel('Time [s]')
hold on
grid on

