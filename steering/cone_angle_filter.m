function [alpha, beta] = cone_angle_filter(t, y, alpha_c, beta_c)
% CONE_ANGLE_FILTER  Filter cone angle to put sail at 0 cone angle
% if the desired steering angle would face towards the sun.

[p, f, g, h, k, L] = unpack_mee(y);

% Calculate resultant cone angle
sc_dir_lvlh = steering2lvlh(alpha_c, beta_c);
CIO = rot_inertial_LVLH(p, f, g, h, k, L);
COI = CIO';
sc_dir_i = CIO * sc_dir_lvlh;
sunlight_dir_i = -sun_direction(t);
c_cone_ang = dot(sc_dir_i, sunlight_dir_i);

% If cone angle would result in negative thrust, produce zero thrust
% instead
if c_cone_ang < 0
    % Point sail edge-on to produce ZERO THRUST
    % Since the Sun is ecliptic, we can just point +90 degrees rot in xy
    to_point_inertial = [sunlight_dir_i(2); -sunlight_dir_i(1); sunlight_dir_i(3)];
    to_point_lvlh = COI * to_point_inertial;
    beta = asin(to_point_lvlh(3));
    alpha = atan2(to_point_lvlh(1), to_point_lvlh(2));
else
    alpha = alpha_c;
    beta = beta_c;
end