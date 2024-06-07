function T = thrust_magnitude
% THRUST_MAGNITUDE  Returns the thrust magnitude for the propulsion system
% convenience function for defining thrust magnitude used across the board
% i.e. so that constant_thrust and sail_thrust can use the same value

% Sail/Sun parameters
P = 9.12e-6; % N/m^2
sigma = 0.01; % kg/m^2
eta = 0.85;

T = 2 * P * eta / sigma;
end