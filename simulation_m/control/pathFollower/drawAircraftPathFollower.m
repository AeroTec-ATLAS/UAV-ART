% Creates an animation of the movement of the aircraft in 3-D
% Inputs
% pos:          a matrix whose rows are the vector positions written in NED
% att:          a matrix whose rows are the euler angles by the order phi 
%               theta psi
% pause_t:      time between updates of the plot
% focused:      if the figure is focused/accompanying the aircraft or not

function drawAircraftPathFollower(t,pos,att,path,pause_t,...
    focused)
    % loads the vertices of the aircraft in XYZ
    load ../autopilot/anim/aircraft.mat  V
    % loads the faces of the aircraft in XYZ
    load ../autopilot/anim/aircraft.mat  F
    % loads the facecolors of the aircraft
    load ../autopilot/anim/aircraft.mat  facecolors

    e = 100;
    bounds = [min(pos(:,2))-e, max(pos(:,2))+e;
              min(pos(:,1))-e, max(pos(:,1))+e;
              min(-pos(:,3))-e, max(-pos(:,3))+e;];

    % Creates a maximized clear figure with the path, title, ...  
    figure('units','normalized','outerposition',[0 0 1 1])
    clf
    drawPath(path,bounds)
    title('Path Follower Simulation')
    xlabel('East [m]')
    ylabel('North [m]')
    zlabel('Altitude [m]')
    
    % allows the execution of a single for loop without having to initially
    % run the renderAircraft function in separate with empty vectors
    aircr = [];
    traj = [];
    
    if focused
        % half the length of each edge of the view (thinking in the view as
        % a cube)
        dist = 50;
    
        for k = 1:size(pos,1)
            [aircr,traj] = renderAircraft(V,F,facecolors,pos(k,:),...
                                               att(k,:),aircr,traj);
            % defines the view centered in the aircraft position in XYZ
            axis([pos(k,2)-dist,pos(k,2)+dist,pos(k,1)-dist,...
                pos(k,1)+dist,-pos(k,3)-dist,-pos(k,3)+dist])
            % pauses the execution during pause_t seconds
            pause(pause_t)
        end
    else
        % defines the view based on its bounds
        axis([bounds(1,1),bounds(1,2),bounds(2,1),bounds(2,2),...
            bounds(3,1),bounds(3,2)])
        grid on

        for k = 1:size(pos,1)
            [aircr,traj] = renderAircraft(V,F,facecolors,pos(k,:),...
                                               att(k,:),aircr,traj);
            title(sprintf("Path Follower Simulation, t=%.2fs, T=%.2fs",...
                t(k),t(end)))
            pause(pause_t)
        end
    end
end

% Transforms from NED to XYZ
% x:    3-by-n matrix
function y = NED2XYZ(x)
    R = [0, 1, 0;
         1, 0, 0;
         0, 0, -1];
    
    y = R * x;
end

% Inputs
% path:     path structure
% bounds:   trajectory bounds in XYZ
function drawPath(path,bounds)
    if path.flag == 1
        % to get the correct intersections the straight and the bounds must
        % be on the same frame which in this case is XYZ
        rXYZ = NED2XYZ(path.r);
        qXYZ = NED2XYZ(path.q);
        
        ints = getIntersections3D(rXYZ,qXYZ,bounds);
        
        xx = ints(1,:);
        yy = ints(2,:);
        zz = ints(3,:);
    else
        cXYZ = NED2XYZ(path.c);
        N = 100;
        th = 0:2*pi/N:2*pi;
        
        xx = cXYZ(1) + path.rho*cos(th);
        yy = cXYZ(2) + path.rho*sin(th);
        zz = cXYZ(3)*ones(size(th));
    end

    plot3(xx,yy,zz,'r')
    hold on
end

% -------------------------------------------------------------------------
% Taken from '../autopilot/anim/drawAircraft'

function [aircf_h,traj_h] = renderAircraft(V,F,facecolors,p,att,...
                                                            aircf_h,traj_h)                 
    V = rotate(V,att);
    V = translate(V,p);
    
    V = NED2XYZ(V);

    if isempty(aircf_h) && isempty(traj_h)
        figure(1)
        aircf_h = patch('Vertices', V', 'Faces', F,...
                     'FaceVertexCData',facecolors,...
                     'FaceColor','flat');
        hold on
        traj_h = plot3(p(2),p(1),-p(3),'--b');
    else
        set(aircf_h,'Vertices',V','Faces',F);
        set(traj_h,'Xdata',[get(traj_h,'Xdata'),p(2)]);
        set(traj_h,'Ydata',[get(traj_h,'Ydata'),p(1)]);
        set(traj_h,'Zdata',[get(traj_h,'Zdata'),-p(3)]);
    end
end

function V = rotate(V,att)
    phi = att(1);
    theta = att(2);
    psi = att(3);
    
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
end

function V = translate(V,p)
  V = V + repmat(p',1,size(V,2));
end
