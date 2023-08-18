function gamma = simple_steering(t, y, ~)
% SIMPLE_STEERING  Simple steering law for orbit-raising
%   gamma = SIMPLE_STEERING(t, y, ~) returns a steering angle
%   which will constantly raise the energy of the orbit by increasing
%   the semi-major axis.

% Attempt to point prograde at all times, unless it would produce backwards thrust
gamma_candidate = 0;
gamma = cone_angle_filter(t, y, gamma_candidate);
end