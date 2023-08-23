function phi_sun = sun_angle(t)
% SUN_ANGLE returns the angle of the sun as a function of time
%   phi_sun = SUN_ANGLE(t) returns the angle of the sun as a function of time
%   t. t is the time in seconds since the vernal equinox.

T_sun = 31557600; % seconds in a year
phi_sun = 2 * pi * t / T_sun;

end