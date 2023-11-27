function [alpha, beta] = simple_steering(~, ~, ~)
% SIMPLE_STEERING  Simple steering law for orbit-raising
%   gamma = SIMPLE_STEERING(t, y, ~) returns a steering angle
%   which will constantly raise the energy of the orbit by increasing
%   the semi-major axis.

% Attempt to point prograde at all times
alpha = 0;
beta = 0;
end