% path follow
%  - follow straight line path or orbit
%
% Modified:
%
% input is:
%   flag - if flag==1, follow waypoint path
%          if flag==2, follow orbit
%   
%   Va^d   - desired airspeed
%   r      - inertial position of start of waypoint path
%   q      - unit vector that defines inertial direction of waypoint path
%   c      - center of orbit
%   rho    - radius of orbit
%   lambda - direction of orbit (+1 for CW, -1 for CCW)
%   xhat   - estimated MAV states (pn, pe, pd, Va, alpha, beta, phi, theta, chi, p, q, r, Vg, wn, we, psi)
%
% output is:
%  Va_c - airspeed command
%  h_c  - altitude command
%  chi_c - heading command
%  phi_ff - feed forward roll command
%
function commands = path_follower(u,P)
    % path follower gains
    chi_infty = 0.4;   % approach angle for large distance from straight-line path
    k_path    = 0.1;   % proportional gain for path following
    k_orbit   = 5;   % proportional gain for orbit following

    flag = u(1);   
    Va_d = u(2);
    
    rn = u(3);
    re = u(4);
    rd = u(5);
    
    qn = u(6);
    qe = u(7);
    qd = u(8);
    
    cn = u(9);
    ce = u(10);
    cd = u(11);
    
    rho_orbit = u(12);
    lam_orbit = u(13);
    
    pn     = u(14);
    pe     = u(15);
    pd     = u(16);
    psi    = u(22);
    
    chi = atan2(Va_d*sin(psi)+P.wind_e, Va_d*cos(psi)+P.wind_n);
    
    if flag == 1 % follow straight line path specified by r and q
        % compute wrapped version of path angle
        chi_q = atan2(qe,qn);
        while (chi_q - chi < -pi), chi_q = chi_q + 2*pi; end
        while (chi_q - chi > +pi), chi_q = chi_q - 2*pi; end

        e_py = -sin(chi_q)*(pn - rn) + cos(chi_q)*(pe - re);

        % heading command
        chi_c = chi_q - chi_infty*(2/pi)*atan(k_path*e_py);

        % commanded altitude

        e_p = [pn-rn; pe-re; pd-rd];

        n = [qe; -qn;0];
        n = n/norm(n);

        s = e_p - (dot(e_p,n))*n;

        sn = s(1);
        se = s(2);

        h_c = -rd - sqrt(sn^2 + se^2)*(qd/(sqrt(qn^2 + qe^2)));

        % roll feedforward command
        phi_ff = 0;
    else
        d = sqrt((pn - cn)^2 + (pe - ce)^2); % distance from orbit center

        % compute wrapped version of angular position on orbit
        varphi = atan2(pe - ce,pn - cn); %alterar
        while (varphi - chi < -pi), varphi = varphi + 2*pi; end
        while (varphi - chi > +pi), varphi = varphi - 2*pi; end

        % heading command      
        chi_c = varphi + lam_orbit*(pi/2+atan(k_orbit*(d-rho_orbit)/rho_orbit)) ; 

        % commanded altitude is the height of the orbit
        h_c = -cd;

        % the roll angle feedforward command 
        phi_ff = 0;
    end
  
    % command airspeed equal to desired airspeed
    Va_c = Va_d;
  
    % create output
    commands = [Va_c; h_c; chi_c; phi_ff];
end