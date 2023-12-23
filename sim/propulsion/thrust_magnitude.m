function T = thrust_magnitude
% convenience function for defining thrust magnitude used across the board

% Sail/Sun parameters
P = 9.12e-6; % N/m^2
sigma = 0.01; % kg/m^2
eta = 0.85;

T = 2 * P * eta / sigma;
end