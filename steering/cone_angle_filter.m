function gamma = cone_angle_filter(t, y, gamma_candidate)
% CONE_ANGLE_FILTER  Filter cone angle to put sail at 0 cone angle
% if the desired steering angle would face towards the sun.

[~, ~, ~, L] = unpack_mee(y);

% Calculate resultant cone angle
phi_sun = sun_angle(t);
alpha = L - pi / 2 - gamma_candidate - phi_sun;

% If cone angle would result in negative thrust, produce zero thrust
% instead
if cos(alpha) < 0
    % Point sail edge-on to produce ZERO THRUST
    gamma = L - phi_sun;
else
    gamma = gamma_candidate;
end