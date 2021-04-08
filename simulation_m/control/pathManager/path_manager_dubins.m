% path_manager_dubins 
%   - follow Dubins paths between waypoint configurations
%
% Modified:  
%   - 4/1/2010 - RWB
%   - 3/198/2019 - RWB
%
% input is:
%   num_waypoints - number of waypoint configurations
%   waypoints    - an array of dimension 5 by PLAN.size_waypoint_array.
%                - the first num_waypoints rows define waypoint
%                  configurations
%                - format for each waypoint configuration:
%                  [wn, we, wd, chi_d, Va_d]
%                  where the (wn, we, wd) is the NED position of the
%                  waypoint, chi_d is the desired course at the waypoint,
%                  and Va_d is the desired airspeed along the path. 
%
% output is:
%   flag - if flag==1, follow waypoint path
%          if flag==2, follow orbit
%   
%   Va^d - desired airspeed
%   r    - inertial position of start of waypoint path
%   q    - unit vector that defines inertial direction of waypoint path
%   c    - center of orbit
%   rho  - radius of orbit
%   lambda = direction of orbit (+1 for CW, -1 for CCW)
%
function out = path_manager_dubins(in,PLAN,start_of_simulation)

  NN = 0;
  num_waypoints = in(1+NN);
  waypoints = reshape(in(2+NN:5*PLAN.size_waypoint_array+1+NN),5,PLAN.size_waypoint_array);
  NN = NN + 1 + 5*PLAN.size_waypoint_array;
  pn        = in(1+NN);
  pe        = in(2+NN);
  h         = in(3+NN);
  % Va      = in(4+NN);
  % alpha   = in(5+NN);
  % beta    = in(6+NN);
  % phi     = in(7+NN);
  % theta   = in(8+NN);
  chi     = in(9+NN);
  % p       = in(10+NN);
  % q       = in(11+NN);
  % r       = in(12+NN);
  % Vg      = in(13+NN);
  % wn      = in(14+NN);
  % we      = in(15+NN);
  % psi     = in(16+NN);
  state     =  in(1+NN:16+NN);
  NN = NN + 16;
  t         = in(1+NN);
 
  p = [pn; pe; pd];
  
% Ligação entre blocos
  persistent waypoints_old   % stored copy of old waypoints
  persistent ptr_a           % waypoint pointer
  persistent state_transition % state of transition state machine
  persistent flag_need_new_waypoints % flag that request new waypoints from path planner
  
 
  if start_of_simulation || isempty(waypoints_old)
      waypoints_old = zeros(5,P.size_waypoint_array);
      flag_need_new_waypoints = 0;
      
  end
  
 
  % if the waypoints have changed, update the waypoint pointer
  if min(min(waypoints==waypoints_old))==0
      ptr_a = 2;
      waypoints_old = waypoints;
      start_node = [waypoints(1:4,ptr_a)', 0, 0];
      end_node   = [waypoints(1:4,ptr_b)', 0, 0];
      dubinspath = dubinsParameters(start_node, end_node, P.R_min);
      flag_first_time_in_state = 1;
      state_transition = 1;
      flag_need_new_waypoints = 0;
  end
  
  
  switch state_trasition
      
      case 1    % follow first orbit until intersect H1
          flag = 2; %following orbit
          rho    = dubinspath.R;
          lambda = dubinspath.lambda_s;
          c      = dubinspath.cs;
          state_trasition
          
          
          if ((p-dubinspath.z1)'*dubinspath.q1 >= 0)&&(flag_first_time_in_state) % start in H1
              state_transition = 2;
              %flag_first_time_in_state = 1;
          %elseif (p-dubinspath.w1)'*dubinspath.q1 >= 0 % entering H1
              %state_transition = 3;
              %flag_first_time_in_state = 1;
          else
              flag_first_time_in_state = 0;
          end
          
          
          
      case 2    %follow first orbit on Dubins path until on right side of H1
          
          
          flag   = 2;  % following orbit
          rho    = dubinspath.R;
          c      = dubinspath.cs;
          lambda = dubinspath.lambda_s;
          
          
          if (p-dubinspath.w1)'*dubinspath.q1 < 0 % get to right side H1
              state_transition = 1;
              flag_first_time_in_state = 1;
          else
              flag_first_time_in_state = 0;
          end
          
          
      case 3    %follow straight line until intersect H2
          
          
      case 4    %follow second orbit until intersect H3
          
          
          
      case 5    %follow first orbit until on right side of H3
  
  
  
  out = [flag; Va_d; r; q; c; rho; lambda; state; flag_need_new_waypoints];

end

