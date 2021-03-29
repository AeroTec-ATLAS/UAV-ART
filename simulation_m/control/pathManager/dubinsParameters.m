% dubinsParameters
%   - Find Dubin's parameters between two configurations
% input is:
%   start_node  - [wn_s, we_s, wd_s, chi_s, 0, 0]
%   end_node    - [wn_e, wn_e, wd_e, chi_e, 0, 0]
%   R           - minimum turn radius
%
% output is:
%   dubinspath  - a matlab structure with the following fieldås
%       dubinspath.ps   - the start position in re^3
%       dubinspath.chis - the start course angle
%       dubinspath.pe   - the end position in re^3
%       dubinspath.chie - the end course angle
%       dubinspath.R    - turn radius
%       dubinspath.L    - length of the Dubins path
%       dubinspath.cs   - center of the start circle
%       dubinspath.lams - direction of the start circle
%       dubinspath.ce   - center of the end circle
%       dubinspath.lame - direction of the end circle
%       dubinspath.w1   - vector in re^3 defining half plane H1
%       dubinspath.q1   - unit vector in re^3 along straight line path
%       dubinspath.w2   - vector in re^3 defining position of half plane H2
%       dubinspath.w3   - vector in re^3 defining position of half plane H3
%       dubinspath.q3   - unit vector defining direction of half plane H3
% 

function dubinspath = dubinsParameters(start_node, end_node, R)

  e1 = [1; 0; 0];

  if norm(start_node(1:2)-end_node(1:2)) <= 3*R
      disp('The distance between nodes must be larger than 3R.');
      dubinspath = [];
  else
    
    ps   = start_node(1:3);
    chi_s = start_node(4);
    pe   = end_node(1:3);
    chi_e = end_node(4);
    
    crs = ps + R*Rotz(pi/2) * [cos(chi_s); sin(chi_s); 0];
    cls = ps + R*Rotz(-pi/2) * [cos(chi_s); sin(chi_s); 0];
    cre = pe + R*Rotz(pi/2) * [cos(chi_e); sin(chi_e); 0];
    cle = pe + R*Rotz(-pi/2) * [cos(chi_e); sin(chi_e); 0];
    
    % compute L1
    v = atan2(crs(2)-cre(2),crs(1)-cre(1));
    L1 = norm(crs-cre) + R * mod(2*pi + mod(v-pi/2,2*pi) ...
        - mod(chi_s-pi/2,2*pi),2*pi) + R * mod(2*pi + mod(chi_e-pi/2,2*pi) ...
        - mod(v-pi/2,2*pi),2*pi);
    
    % compute L2
    l = norm(cle-crs);
    v = atan2(crs(2)-cle(2),crs(1)-cle(1));
    v2 = v - pi/2 + asin(2*R/l); 
    L2 = sqrt(l^2-4*R^2) + R * mod(2*pi + mod(v2,2*pi) ...
        - mod(chi_s-pi/2,2*pi),2*pi) + R * mod(2*pi + mod(v2+pi,2*pi) ...
        - mod(chi_e+pi/2,2*pi),2*pi);
    
    % compute L3
    l = norm(cre-cls);
    v = atan2(cls(2)-cre(2),cls(1)-cre(1));
    v2 = acos(2*R/l); 
    L3 = sqrt(l^2-4*R^2) + R * mod(2*pi + mod(chi_s+pi/2,2*pi) ...
        - mod(v+v2/2,2*pi),2*pi) + R * mod(2*pi + mod(chi_e-pi/2,2*pi) ...
        - mod(v+v2-pi,2*pi),2*pi);
    
    % compute L4
    v = atan2(cls(2)-cle(2),cls(1)-cle(1));
    L4 = norm(cls-cle) + R * mod(2*pi + mod(chi_s+pi/2,2*pi) ...
        - mod(v+pi/2,2*pi),2*pi) + R * mod(2*pi + mod(v+pi/2,2*pi) ...
        - mod(chi_e+pi/2,2*pi),2*pi);
    
    % L is the minimum distance
    [L,idx] = min([L1,L2,L3,L4]);
    switch(idx)
        case 1
            cs = crs;
            lambda_s = 1;
            ce = cre;
            lambda_e = 1;
            q1 = (ce-cs)/norm(ce-cs);
            z1 = cs+R*Rotz(-pi/2)*q1;
            z2 = ce+R*Rotz(-pi/2)*q1;
            
        case 2
            cs = crs;
            lambda_s = 1;
            ce = cle;
            lambda_e = -1;
            l = norm(ce-cs);
            v = atan2(ce(2)-cs(2),ce(1)-cs(1));
            v2 = v-pi/2+asin(2*R/l);
            q1 = Rotz(theta2+pi/2)*e1;
            z1 = cs+R*Rotz(v2)*e1;
            z2 = ce+R*Rotz(v2+pi)*e1;
            
        case 3
            cs = cls;
            lambda_s = -1;
            ce = cre;
            lambda_e = 1;
            l = norm(ce-cs);
            v = atan2(ce(2)-cs(2),ce(1)-cs(1));
            v2 = acos(2*R/l);
            q1 = Rotz(v+v2-pi/2)*e1;
            z1 = cs+R*Rotz(v+v2)*e1;
            z2 = ce+R*Rotz(v+v2-pi)*e1;
            
        case 4
            cs = cls;
            lambda_s = -1;
            ce = cle;
            lambda_e = -1;
            q1 = (ce-cs)/norm(ce-cs);
            z1 = cs+R*Rotz(pi/2)*q1;
            z2 = ce+R*Rotz(pi/2)*q1;    %q2=q1
    end
    
    z3 = pe;
    q3 = Rotz(chi_e)*e1;
       
    % assign path variables
    dubinspath.ps   = ps;
    dubinspath.chis = chi_s;
    dubinspath.pe   = pe;   
    dubinspath.chie = chi_e;
    dubinspath.R    = R;
    dubinspath.L    = L;
    dubinspath.cs   = cs;
    dubinspath.lams = lambda_s;
    dubinspath.ce   = ce;
    dubinspath.lame = lambda_e;
    dubinspath.z1   = z1;
    dubinspath.q1   = q1;
    dubinspath.z2   = z2;   
    dubinspath.z3   = z3;
    dubinspath.q3   = q3;
  end
end

function Rot = Rotz(v)
    Rot = [cos(v), -sin(v), 0;
           sin(v), cos(v), 0;
           0, 0, 1];
end


