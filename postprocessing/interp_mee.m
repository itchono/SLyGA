function [y_interp, t_interp] = interp_mee(y, t, points_per_orbit)
% INTERP_MEE Interpolate MEE elements obtained from propagation to have an
% equal number of points per orbit
%   [y_interp, t_interp] = interp_mee(y, t, points_per_orbit)
%  interpolates the MEEs obtained from propagation to smooth out the
%  solution, primarily for plotting purposes.
% if points_per_orbit is not specified, it is set to 50.

if nargin < 6
    points_per_orbit = 50;
end
L_step = 2 * pi / points_per_orbit;

L_interp = y(end, 1):L_step:y(end, end);
y_interp = interp1(y(end, :), y', L_interp)';
t_interp = interp1(y(end, :), t, L_interp);

end