function acc_lvlh = sail_thrust(t, y, gamma)
% SAIL_THRUST  Calculates the thrust of the solar sail in the LVLH frame.
%   acc_lvlh = sail_thrust(t, y, gamma) calculates the thrust of the solar
%   sail in the LVLH frame, given the time t, the state vector y, and the
%   roll angle gamma.
%
%   Inputs:
%       t           Time (s)
%       y           State vector (mee)
%       gamma       Steering angle (rad)
%
%   Outputs:
%       acc_lvlh    Acceleration vector (m/s^2)
%

[~, ~, ~, L] = unpack_mee(y);

% Sail/Sun parameters
P = 9.12e-6; % N/m^2
sigma = 0.001; % kg/m^2
eta = 0.85;

% Calculate Cone Angle
alpha = L - pi / 2 - gamma - sun_angle(t);

efficiency = 2 * P * eta / sigma;
direction = [sin(gamma); cos(gamma)];

% Solar sail thrust equation
acc_lvlh = efficiency .* sign(cos(alpha)) .* cos(alpha).^2 .* direction;

end
