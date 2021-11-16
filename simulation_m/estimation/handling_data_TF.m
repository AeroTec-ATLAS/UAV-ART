% UAV-ART // Aerotéc - Núcleo de estudantes de Engenharia Aeroespacial
% Authors: - Hugo Pereira
%          - Pedro Martins
%          - Simão Caeiro

%% Remove alpha and beta fields (blank)

data = rmfield(data,{'alpha','beta'});

%% Trim the data: the wind estimator takes some time + the pitot tube died in mid-air
% This can be improved by a function 
pointer = true;
i = 1;
while pointer
    if  ~isempty(data(i).wx) && ~isempty(data(i).wy) && ~isempty(data(i).wz)
        data(1:i-1) = [];
        pointer = false;
    end
    i = i + 1;
end
pointer = true;
i = 1;
while pointer
    if (isnan(data(i).IAS))
        data(i:end) = [];
        pointer = false;
    end
    i = i + 1;
end

%% PWM to rad conversion
% This can be wrong
% ch1 -> ailerons
% ch2 -> elevator
% ch3 -> throttle
% ch4 -> rudder

% Elevator
min_PWM_E = 1108;
max_PWM_E = 1827;
min_rad_E = -33*pi/180;
max_rad_E = 28.2*pi/180;
delta_E = linear_interpol([data.RCch2], max_PWM_E, min_PWM_E, ...
    max_rad_E, min_rad_E);

% Ailerons
min_PWM_A = 1107;
max_PWM_A = 1764;
min_rad_A = -57.5*pi/180;
max_rad_A = 39*pi/180;
delta_A = linear_interpol([data.RCch1], max_PWM_A, min_PWM_A, ...
    max_rad_A, min_rad_A);

% Rudder
min_PWM_R = 1110;
max_PWM_R = 1931;
min_rad_R = -25.6*pi/180;
max_rad_R = 17.2*pi/180;
delta_R = linear_interpol([data.RCch4], max_PWM_R, min_PWM_R, ...
    max_rad_R, min_rad_R);

% Throttle
min_PWM_T = 1140;
max_PWM_T = 1932;
min_T = 0;
max_T = 1;
delta_T = linear_interpol([data.RCch3], max_PWM_T, min_PWM_T, ...
    max_T, min_T);

%% AoA and sideslip angle computing

% Relative velocities in the inertial frame
vr_east = [data.veast] - [data.wx];
vr_north = [data.vnorth] - [data.wy];
vr_down = [data.vdown] - [data.wz];
vr_x = zeros(1,length(data)); vr_y = zeros(1,length(data));
vr_z = zeros(1,length(data));

% Relative velocities in the body frame
for i = 1:length(data)
    Rot = rotateFromInertialtoBody_R(data(i).phi,data(i).theta,data(i).psi);
    vel = Rot*[vr_east;vr_north;vr_down];
    vr_x(i) = vel(1);
    vr_y(i) = vel(2);
    vr_z(i) = vel(3);
end

alpha = zeros(1,length(data)); beta = zeros(1,length(data));
Va = zeros(1,length(data));

% AoA and sideslip angle computation
for i = 1:length(data)
    Va(i) = sqrt(vr_x(i)^2 + vr_y(i)^2 + vr_z(i)^2);
    alpha(i) = atan(vr_z(i)/Va(i));
    beta(i) = asin(vr_y(i)/Va(i));
end


%% Functions

% Linear interpolation: PWM signal to rad
function data_array = linear_interpol(PWM_array, max_PWM, min_PWM, max_rad, min_rad)

data_array = (PWM_array - min_PWM)/(max_PWM - min_PWM)*...
    (max_rad - min_rad) + min_rad;

end



