function [pos, dir] = sun_position(t)
% Returns a 3D vector of sun direction in an ECI frame
% t is the number of seconds after vernal equinox

epsilon = 23.439; % obliquity of the ecliptic

lambda = sun_angle(t);
dir = [cos(lambda); sin(lambda)*sind(epsilon); sin(lambda)*sind(epsilon)];
pos = dir * 149597870691;

end