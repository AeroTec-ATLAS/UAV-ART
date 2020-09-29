savepath = strcat(pwd,'\txt_logs_wAero\');
date_str = char(datetime('now','Format','yyyy-MM-dd_HH.mm'));
filename = strcat(savepath,date_str,'.txt');

fileID = fopen(filename,'w');

f_str = '%13s ';
F = repmat(f_str,1,32);
F = strcat(F(1:end-1),'\n');
fprintf(fileID,F,'time [s]','theta [rad]', 'psi [rad]', ...
    'phi [rad]', 'q [rad/s]', 'r [rad/s]', 'p [rad/s]', 'pn [m]', 'pe [m]', ...
    'h [m]', 'u [m/s]', 'v [m/s]', 'w [m/s]', 'Va [m/s]', 'alpha [rad]',...
    'beta [rad]', 'delta_a [rad]', 'delta_e [rad]', 'delta_t', ...
    'delta_r [rad]', 'F_D [N]', 'F_Y [N]', 'F_L [N]', 'fx [N]', ...
    'fy [N]','fz [N]', 'l_aero [N.m]', 'm_aero [N.m]', 'n_aero [N.m]', ...
    'l [N.m]', 'm [N.m]', 'n [N.m]');

A = [t' att(:,2) att(:,3) att(:,1) ang_v(:,2) ang_v(:,3) ang_v(:,1) ...
    pos(:,1:2) -pos(:,3) v Va alpha beta delta(:,2) delta(:,1) delta(:,4) ...
    delta(:,3) F_aero F_body T_aero T_body];

% A = A(2301:end,:);
A = A';

str1 = '%3.4f %1.4f %1.4f %1.4f %3.4f %3.4f %3.4f %5.4f %5.4f %3.4f %3.4f';
str2 = ' %3.4f %3.4f %2.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %3.4f %3.4f';
str3 = ' %3.4f %3.4f %3.4f %3.4f %3.4f %3.4f %3.4f %3.4f %3.4f %3.4f\n';
fprintf(fileID,strcat(str1,str2,str3),A);
fclose(fileID);