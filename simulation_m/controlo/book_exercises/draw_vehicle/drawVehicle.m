 function drawVehicle(uu)

    % process inputs to function
    pn       = uu(1);       % inertial North position
    pe       = uu(2);       % inertial East position
    pd       = uu(3);       % inercial Down position
    u        = uu(4);
    v        = uu(5);
    w        = uu(6);
    phi      = uu(7);       % roll angle
    theta    = uu(8);       % pitch angle
    psi      = uu(9);       % yaw angle
    p        = uu(10);       % roll rate
    q        = uu(11);       % pitch rate
    r        = uu(12);       % yaw rate
    t        = uu(13);       % time

    % define persistent variables
    persistent vehicle_handle;
    persistent Vertices
    persistent Faces
    persistent facecolors

    % first time function is called, initialize plot and persistent vars
    if t==0
        figure(1), clf
        [Vertices,Faces,facecolors] = defineVehicleBody;
        vehicle_handle = drawVehicleBody(Vertices,Faces,facecolors,...
                                               pn,pe,pd,phi,theta,psi,...
                                               [],'normal');

        title('Vehicle')
        xlabel('East')
        ylabel('North')
        zlabel('-Down')
        view(32,47)  % set the view angle for figure
        axis([-10,10,-10,10,-10,10]);
        hold on

    % at every other time step, redraw base and rod
    else
        drawVehicleBody(Vertices,Faces,facecolors,...
                           pn,pe,pd,phi,theta,psi,...
                           vehicle_handle);
    end
 end


%=======================================================================
% drawVehicle
% return handle if 3rd argument is empty, otherwise use 3rd arg as handle
%=======================================================================
%
function handle = drawVehicleBody(V,F,facecolors,pn,pe,pd,phi,theta,psi,...
                                     handle,mode)

  V = rotate(V, phi, theta, psi);  % rotate vehicle

  V = translate(V, pn, pe, pd);  % translate vehicle
  % transform vertices from NED to XYZ (for matlab rendering)
  xyzNED = [...
      0, 1, 0;...
      1, 0, 0;...
      0, 0, -1;...
      ];
  V = xyzNED*V;

  if isempty(handle)
  handle = patch('Vertices', V', 'Faces', F,...
                 'FaceVertexCData',facecolors,...
                 'FaceColor','flat',...
                 'EraseMode', mode);
  else
    set(handle,'Vertices',V','Faces',F);
    drawnow
  end

end


function pts=rotate(pts,phi,theta,psi)

  % define rotation matrix (right handed)
  R_roll = [...
          1, 0, 0;...
          0, cos(phi), sin(phi);...
          0, -sin(phi), cos(phi)];
  R_pitch = [...
          cos(theta), 0, -sin(theta);...
          0, 1, 0;...
          sin(theta), 0, cos(theta)];
  R_yaw = [...
          cos(psi), sin(psi), 0;...
          -sin(psi), cos(psi), 0;...
          0, 0, 1];
  R = R_roll*R_pitch*R_yaw;
    % note that R above either leaves the vector alone or rotates
    % a vector in a left handed rotation.  We want to rotate all
    % points in a right handed rotation, so we must transpose
    % R = R';

  % rotate vertices
  pts = R*pts;

end


% translate vertices by pn, pe, pd
function pts = translate(pts,pn,pe,pd)

  pts = pts + repmat([pn;pe;pd],1,size(pts,2));

end


%=======================================================================
% defineVehicleBody
%=======================================================================
function [V,F,facecolors] = defineVehicleBody

  % Define the vertices (physical location of vertices
      V = [...
          0 5 0;... %1
          1 4 0;... %2
          1 1 0;... %3
          8 -2 0;... %4
          8 -3 0;... %5
          1 -2 0;... %6
          1 -5 0;... %7
          3 -6 0;... %8
          3 -7 0;... %9
          0.5 -6 0;... %10
          0 -7 0;... %11
          -0.5 -6 0;... %12
          -3 -7 0;... %13
          -3 -6 ;... %14
          -1, -5 0;... %15
          -1 -2 0;... %16
          -8 -3 0;... %17
          -8 -2 0;... %18
          -1 1 0;... %19
          -1 4 0;... %20
          0 4 -1.5;... %21
          0 -5.5 -1.5;... %22
          0 -6 -4.5;... %23
          0 -7 -4.5;... %24
          0 -7 0;... %25
          0 -4 1.5;... %26
          0 2 1.5;... %27
          ]';

       % define faces as a list of vertices numbered above

      F = [...
          1, 2, 7, 11;... % body top
          11, 15, 20, 1;...
          3, 4, 5, 6;... % asa direita
          7, 8, 9, 10;... % mini asa dir
          12, 13, 14, 15;... % mini asa esq
          16, 17, 18, 19;... % asa esquerda
          1, 21, 22, 25;... % body side
          22, 23, 24, 25;...
          1, 25, 26, 27;...
          ];

       % define colors for each face
       myred = [1, 0, 0];
       mygreen = [0, 1, 0];
       myblue = [0, 0, 1];
       myyellow = [1, 1, 0];

       facecolors = [...
           myred;... % body top
           myred;...
           mygreen;... % asa direita
           myblue;... % mini asa dir
           myblue;... % mini asa esq
           mygreen;... % asa esquerda
           myyellow;... % body side
           myyellow;...
           myyellow;...
       ];

end
