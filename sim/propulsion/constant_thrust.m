function acc_lvlh = constant_thrust(~, ~, gamma)
% CONSTANT_THRUST  Simplified constant thrust model
% in the direction of the sail normal
% equal to full thrust when the sail is normal to the sun
%   acc_lvlh = CONSTANT_THRUST(t, y, gamma) calculates the thrust
%   acceleration in the LVLH frame at time t for the state y and sail
%   angle gamma.
%
%   Inputs:
%       t           Time (s)
%       y           State vector in modified equinoctial elements
%       gamma       Steering angle (rad)
%
%   Outputs:
%       acc_lvlh    Thrust acceleration in the LVLH frame (m/s^2)
%

% parameters
P = 9.12e-6; % N/m^2
sigma = 0.001; % kg/m^2
eta = 0.85;

% thrust
efficiency = 2 * P * eta / sigma;
direction = [sin(gamma); cos(gamma)];
acc_lvlh = efficiency .* direction;

end
