function [alpha, beta] = lvlh2steering(n_lvlh)
% LVLH2STEERING  Converts a direction vector in LVLH into alpha and beta steering angles
%
%   [alpha, beta] = lvlh2steering(n_lvlh) converts a direction vector in LVLH
%   into alpha and beta steering angles.
%
%  Inputs:
%   n_lvlh - direction vector in LVLH
%
%  Outputs:
%   alpha - steering angle in the y-x plane (rad)
%   beta - steering angle towards the z-axis (rad)

% Converts a direction vector in LVLH into alpha and beta steering angles

beta = atan2(n_lvlh(3), sqrt(n_lvlh(1).^2+n_lvlh(2).^2));
alpha = atan2(n_lvlh(1), n_lvlh(2));
end