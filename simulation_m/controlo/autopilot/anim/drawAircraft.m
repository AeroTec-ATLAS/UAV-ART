function drawAircraft(p,ang,V,F,facecolors,pause_t)

    figure(1), clf
    
    title('Autopilot Simulation','Fontsize',14)
    xlabel('East [m]','Fontsize',12)
    ylabel('North [m]','Fontsize',12)
    zlabel('Altitude [m]','Fontsize',12)
%     view(-32,32)
    e = 10;
    
    axis([min(p(:,2))-e,max(p(:,2))+e,min(p(:,1))-e,max(p(:,1))+e,... 
                                        min(-p(:,3))-e,max(-p(:,3))+e])
    grid on
    
    aircf_h = [];
    traj_h = [];
    
    set(figure(1),'Units','normalized','OuterPosition',[0 0 1 1])
    pause(1)
    
    
    for k = 1:size(p,1)
        [aircf_h,traj_h] = renderAircraft(V,F,facecolors,p(k,:),...
                                                ang(k,:),aircf_h,traj_h);
        pause(pause_t)
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [aircf_h,traj_h] = renderAircraft(V,F,facecolors,p,ang,...
                                                            aircf_h,traj_h)
                                 
    V = rotate(V,ang);
    V = translate(V,p);
    
    % transform vertices from NED to XYZ (for matlab rendering)
    R = [...
          0, 1, 0;...
          1, 0, 0;...
          0, 0, -1;...
          ];
    V = R*V;

    if isempty(aircf_h) && isempty(traj_h)
    figure(1)
    aircf_h = patch('Vertices', V', 'Faces', F,...
                 'FaceVertexCData',facecolors,...
                 'FaceColor','flat');
    hold on
    traj_h = plot3(p(2),p(1),-p(3),'--b','Linewidth',1.5);
    
    else
        set(aircf_h,'Vertices',V','Faces',F);
        set(traj_h,'Xdata',[get(traj_h,'Xdata'),p(2)]);
        set(traj_h,'Ydata',[get(traj_h,'Ydata'),p(1)]);
        set(traj_h,'Zdata',[get(traj_h,'Zdata'),-p(3)]);
    end
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function V = rotate(V,ang)

    phi = ang(1);
    theta = ang(2);
    psi = ang(3);
    
    R_roll = [...
          1, 0, 0;...
          0, cos(phi), -sin(phi);...
          0, sin(phi), cos(phi)];
    R_pitch = [...
          cos(theta), 0, sin(theta);...
          0, 1, 0;...
          -sin(theta), 0, cos(theta)];
    R_yaw = [...
          cos(psi), -sin(psi), 0;...
          sin(psi), cos(psi), 0;...
          0, 0, 1];
    
    R = R_yaw*R_pitch*R_roll;
    V = R*V;
%     V = V';
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function V = translate(V,p)

  V = V + repmat(p',1,size(V,2));
  
end


