% path_manager_dubins 
%   - follow Dubins paths between waypoint configurations
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
 
  p = [pn; pe; -h];
  
% LigaÁ?o entre blocos
  persistent waypoints_old   % stored copy of old waypoints
  persistent ptr_a           % waypoint pointer
  persistent ptr_b           % waypoint pointer
  persistent state_transition % state of transition state machine
  persistent dubinspath
  persistent flag_need_new_waypoints % flag that request new waypoints from path planner
  persistent flag_first_time_in_state

  
 
  if start_of_simulation || isempty(waypoints_old)
      waypoints_old = zeros(5,PLAN.size_waypoint_array);
      flag_need_new_waypoints = 0;
      state_transition = 0;
      flag_first_time_in_state = 1;
      
  end
  
 
  % if the waypoints have changed, update the waypoint pointer
  if min(min(waypoints==waypoints_old))==0
      ptr_a = 1;
      ptr_b = 2;
      waypoints_old = waypoints;
      start_node = [waypoints(1:4,ptr_a)', 0, 0];
      end_node   = [waypoints(1:4,ptr_b)', 0, 0];
      dubinspath = dubinsParameters(start_node, end_node, PLAN.R_min);
      state_transition = 1;
      flag_first_time_in_state = 1;
      flag_need_new_waypoints = 0;
  end
  
  
  switch state_transition
       
      case 0 %beginning of simulation
          flag   = 1;
          r      = dubinspath.ps;
          q      = dubinspath.q1;
          rho    = dubinspath.R;
          lambda = dubinspath.lambda_s;
          c      = dubinspath.cs;
          Va_d   = waypoints(5,ptr_a); % desired airspeed along waypoint path
          flag_first_time_in_state =0;

         
      case 1    %follow first orbit until intersect H1 
          flag = 2; %following orbit
          rho    = dubinspath.R;
          lambda = dubinspath.lambda_s;
          c      = dubinspath.cs;
          r      = dubinspath.ps; %not used
          q      = dubinspath.q1; %not used
          Va_d   = waypoints(5,ptr_a); 
          
          if ((p-dubinspath.z1)'*dubinspath.q1 >= 0)&&(flag_first_time_in_state) %if the aicraft starts in H1
              state_transition = 2;
              flag_first_time_in_state = 1;
          elseif (p-dubinspath.z1)'*dubinspath.q1 >= 0 %if the aircraft enters H1 after coming from state 2 or if it enters H1 but didnt start in H1
              state_transition = 3;
              flag_first_time_in_state = 1;
          else
              flag_first_time_in_state = 0;
          end
          
          
      case 2    %follow first orbit until leaves H1 if it started there
          
          
          flag   = 2;  % following orbit
          rho    = dubinspath.R;
          lambda = dubinspath.lambda_s;
          c      = dubinspath.cs;
          r      = dubinspath.ps; %not used
          q      = dubinspath.q1; %not used
          Va_d   = waypoints(5,ptr_a);        
          
          if (p-dubinspath.z1)'*dubinspath.q1 < 0 %if it leaves H1
              state_transition = 1;
              flag_first_time_in_state = 1;
          else
              flag_first_time_in_state = 0;
          end
          
          
     case 3 %follow straight line on Dubins path until intersect H2
         
            flag   = 1;  %following straight line path
            rho    = dubinspath.R;
            lambda = dubinspath.lambda_s; %not used
            c      = dubinspath.cs; %not used
            r      = dubinspath.z1; 
            q      = dubinspath.q1;
            Va_d   = waypoints(5,ptr_a); 
            flag_first_time_in_state = 0;
            
            if (p-dubinspath.z2)'*dubinspath.q1 >= 0 %if enters H2
                state_transition = 4;
                flag_first_time_in_state = 1;
            end
          
          
      case 4    %follow second orbit until intersect H3
          
          flag   = 2;  % following orbit
          rho    = dubinspath.R;
          lambda = dubinspath.lambda_e;
          c      = dubinspath.cs;
          r      = dubinspath.z1; %not used
          q      = dubinspath.q1; %not used
          Va_d   = waypoints(5,ptr_a); % desired airspeed along waypoint path
          flag_first_time_in_state = 0;

          if ((p-dubinspath.z3)'*dubinspath.q3 >= 0)&&(flag_first_time_in_state) %if the aicraft starts in H3
              state_transition = 5;
              flag_first_time_in_state=1;
              
          elseif (p-dubinspath.z3)'*dubinspath.q3 >= 0 %if the aircraft enters H3 after coming from state 5 or if it enters H3 but didnt start in H3
              % increase the waypoint pointer
              if ptr_a==num_waypoints-1
                  flag_need_new_waypoints = 1;
                  ptr_b = ptr_a+1;
              else
                  ptr_a = ptr_a+1;
                  ptr_b = ptr_a+1;
                  state_transition = 1;
                  flag_first_time_in_state = 1;
              end
              % plan new Dubin's path to next waypoint configuration
              start_node = [waypoints(1:4,ptr_a)', 0, 0];
              end_node   = [waypoints(1:4,ptr_b)', 0, 0];
              dubinspath = dubinsParameters(start_node, end_node, PLAN.R_min);
          else
              flag_first_time_in_state = 0;
          end
          
          
      case 5    %follow first orbit until leaves H3 if it started there
  
          flag   = 2;  % following orbit
          rho    = dubinspath.R;
          lambda = dubinspath.lambda_e;
          c      = dubinspath.cs;
          r      = dubinspath.z1; %not used
          q      = dubinspath.q1; %not used
          Va_d   = waypoints(5,ptr_a);
          flag_first_time_in_state = 0;
          
         
          if (p-dubinspath.z3)'*dubinspath.q3 < 0 %if it leaves H3
              state_transition = 4;
              flag_first_time_in_state = 1;
          else
              flag_first_time_in_state = 0;
          end
  end
  
  out = [flag; Va_d; r; q; c; rho; lambda; state; flag_need_new_waypoints];

end