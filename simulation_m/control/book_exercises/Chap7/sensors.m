% sensors.m
%   Compute the output of rate gyros, accelerometers, and pressure sensors
%
%  Revised:
%   3/5/2010  - RB 
%   5/14/2010 - RB

function y = sensors(uu, P)

    % relabel the inputs
%    pn      = uu(1);
%    pe      = uu(2);
    pd      = uu(3);
%    u       = uu(4);
%    v       = uu(5);
%    w       = uu(6);
    phi     = uu(7);
    theta   = uu(8);
%    psi     = uu(9);
    p       = uu(10);
    q       = uu(11);
    r       = uu(12);
    F_x     = uu(13);
    F_y     = uu(14);
    F_z     = uu(15);
%    M_l     = uu(16);
%    M_m     = uu(17);
%    M_n     = uu(18);
    Va      = uu(19);
%    alpha   = uu(20);
%    beta    = uu(21);
%    wn      = uu(22);
%    we      = uu(23);
%    wd      = uu(24);

    rho = P.rho;
    g = P.gravity;
    m = P.mass;
    
    % simulate rate gyros (units are rad/sec)
    y_gyro_x = p + normrnd(0,P.gyro_dev_x);
    y_gyro_y = q + normrnd(0,P.gyro_dev_y);
    y_gyro_z = r + normrnd(0,P.gyro_dev_z);

    % simulate accelerometers (units of g)
    y_accel_x = F_x/(m*g) + sin(theta) + normrnd(0,P.acc_dev_x)/g;
    y_accel_y = F_y/(m*g) - cos(theta)*sin(phi) + normrnd(0,P.acc_dev_y)/g;
    y_accel_z = F_z/(m*g) - cos(theta)*cos(phi) + normrnd(0,P.acc_dev_z)/g;

    % simulate pressure sensors
    y_static_pres = -pd*rho*g + P.abs_press_beta + normrnd(0,P.abs_press_dev);
    y_diff_pres = rho*Va^2/2 + P.diff_press_beta + normrnd(0,P.diff_press_dev);

    % construct total output
    y = [...
        y_gyro_x;...
        y_gyro_y;...
        y_gyro_z;...
        y_accel_x;...
        y_accel_y;...
        y_accel_z;...
        y_static_pres;...
        y_diff_pres;...
    ];

end



