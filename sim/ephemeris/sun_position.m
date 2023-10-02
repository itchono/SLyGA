function [pos, dir] = sun_position(t)

% SUN_POSITION - Returns the position of the sun in the ECI frame
%
% [pos, dir] = sun_position(t)
%
% Inputs:
%   t - Number of seconds after vernal equinox
%
% Outputs:
%   pos - Position of the sun in the ECI frame (m)
%   dir - Direction of the sun in the ECI frame (unit vector)

epsilon = 23.439; % obliquity of the ecliptic

lambda = sun_angle(t);
dir = [cos(lambda); sin(lambda)*sind(epsilon); sin(lambda)*sind(epsilon)];
pos = dir * 149597870691;

end