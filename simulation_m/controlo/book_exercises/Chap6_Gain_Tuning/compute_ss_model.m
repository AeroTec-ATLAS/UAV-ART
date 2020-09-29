function [A_lon,B_lon,A_lat,B_lat] = compute_ss_model(filename,x_trim,u_trim)
% x_trim is the trimmed state,
% u_trim is the trimmed input

A_lat = eye(5,5);
B_lat = zeros(5,2);

A_lon = eye(5,5);
B_lon = zeros(5,2);
  
% add stuff here  

end 