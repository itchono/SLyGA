function acc_lvlh = sail_thrust(t, y, alpha, beta)
% SAIL_THRUST  Calculates the thrust of the solar sail in the LVLH frame.
%   acc_lvlh = sail_thrust(t, y, alpha, beta) calculates the thrust
%   acceleration in the LVLH frame at time t for the state y and steering
%   angles alpha, beta.
%
%   Inputs:
%       t           Time (s)
%       y           State vector (mee)
%       alpha       Steering angle (rad)
%       beta        Steering angle (rad)
%
%   Outputs:
%       acc_lvlh    Acceleration vector (m/s^2)
%

[p, f, g, h, k, L] = unpack_mee(y);

% Sail/Sun parameters
P = 9.12e-6; % N/m^2
sigma = 0.01; % kg/m^2
eta = 0.85;

% Calculate Cone Angle
sc_dir_lvlh = steering2lvlh(alpha, beta);
sc_dir_i = rot_inertial_LVLH(p, f, g, h, k, L) * sc_dir_lvlh;
sunlight_dir_i = -sun_direction(t);
c_cone_ang = dot(sc_dir_i, sunlight_dir_i);

% prefactor for sail thrust
efficiency = 2 * P * eta / sigma;

% Solar sail thrust equation
acc_lvlh = efficiency .* sign(c_cone_ang) .* c_cone_ang.^2 .* sc_dir_lvlh;

end
