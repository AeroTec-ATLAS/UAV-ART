% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - José Neves
%          - Pedro Martins
%          - Simão Caeiro

% AoA and sideslip angle estimation

useLogs = true;
real = [3;3;0];
descriptor = "3_3_0_no_gusts_"+useLogs;

mkdir('estim_alpha_beta_results')

if useLogs
    read_data
    
    u = [data.u]';
    u_r = [data.Va]';
    phi = [data.phi]';
    theta = [data.theta]';
    psi = [data.psi]';
    time = [data.time]';
else
    if ~exist('v','var')
        run('../control/autopilot/main')
    end
    
    u = v(:,1);
    w = v(:,3);
    vg = v(:,2);    % vg to denote it is the 2nd component of the ground
                    % speed. One cannot use v since it is already being
                    % used
    phi = att(:,1);
    theta = att(:,2);
    psi = att(:,3);
    
    time = t';
end

Phi = zeros(length(u),3);
vRot = zeros(length(u),3);
wRot = zeros(length(u),3);

for i = 1:length(u)
    Rot = rotateFromInertialtoBody_R(phi(i),theta(i),psi(i));
    Phi(i,:) = [1,0,0] * Rot;
    vRot(i,:) = [0,1,0] * Rot;
    wRot(i,:) = [0,0,1] * Rot;
end

v_wn = (Phi'*Phi)\(Phi'*(u-u_r));

relErrors = (v_wn-real)/abs(real)*100;

v_r = vg - vRot*v_wn;
w_r = w - wRot*v_wn;
Va = norm([u_r,v_r,w_r]);

alphaEst = atan2(w_r,u_r);

%% Results presentation
% If not using logs, presents the simulated wind speed
% if ~useLogs
%     PhiInv = zeros(length(u),3);
%     vRotInv = zeros(length(u),3);
%     wRotInv = zeros(length(u),3);
% 
%     for i = 1:length(u)
%         Rot = rotateFromInertialtoBody_R(phi(i),theta(i),psi(i));
%         PhiInv(i,:) = [1,0,0] * Rot';
%         vRotInv(i,:) = [0,1,0] * Rot';
%         wRotInv(i,:) = [0,0,1] * Rot';
%     end
%     
%     figure
%     subplot(3,1,1)
%     plot(time,diag(PhiInv*wind_data'),'r')
%     grid on
%     xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
%     ylabel('$u_w$ (m/s)','Interpreter','latex','FontSize',18)
% 
%     set(gcf,'Units','Inches');
%     pathFigPos = get(gcf,'Position');
%     set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches',...
%         'PaperSize',[pathFigPos(3), pathFigPos(4)])
%     print(gcf,"estim_alpha_beta_results/errors_"+descriptor,'-dpdf','-r0')
% end

% Print data to console
fprintf("Real\n")
fprintf("[%.2f \t %.2f \t %.2f]^T\n", real(1), real(2), real(3))
fprintf("Experimental\n")
fprintf("[%.2f \t %.2f \t %.2f]^T\n", v_wn(1), v_wn(2), v_wn(3))
fprintf("Relative errors\n")
fprintf("[%.2f \t %.2f \t %.2f]^T\n", relErrors(1), relErrors(2), ...
    relErrors(3))


% Plot errors in estimation
figure
plot(time,u-u_r-Phi*v_wn,'r')
grid on
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$u-u_r-R_n^b v_w^n$ (m/s)','Interpreter','latex','FontSize',18)

set(gcf,'Units','Inches');
pathFigPos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches',...
    'PaperSize',[pathFigPos(3), pathFigPos(4)])
print(gcf,"estim_alpha_beta_results/errors_"+descriptor,'-dpdf','-r0')


% Plot alpha
figure
plot(time,alpha/pi*180,'r',time,alphaEst/pi*180,'b')
grid on
xlabel('$t$ (s)','Interpreter','latex','FontSize',18)
ylabel('$\alpha$ (rad)','Interpreter','latex','FontSize',18)
legend('Simulado','Estimado','location','best','Interpreter','latex',...
    'FontSize',12)

set(gcf,'Units','Inches');
pathFigPos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches',...
    'PaperSize',[pathFigPos(3), pathFigPos(4)])
print(gcf,"estim_alpha_beta_results/alpha_"+descriptor,'-dpdf','-r0')