function [p_interp, f_interp, g_interp, L_interp, t_interp] = interp_mee(p, f, g, L, t, points_per_orbit)
% INTERP_MEE Interpolate MEE elements obtained from propagation to have an
% equal number of points per orbit
%   [p_interp, f_interp, g_interp, L_interp, t_interp] = interp_mee(p, f, g, L, t, interp_step)
%  interpolates the MEE elements p, f, g, L obtained from propagation to smooth out the
%  solution, primarily for plotting purposes.
% if points_per_orbit is not specified, it is set to 50.

if nargin < 6
    points_per_orbit = 50;
end

L_step = 2 * pi / points_per_orbit;

L_interp = L(1):L_step:L(end);
p_interp = interp1(L, p, L_interp);
f_interp = interp1(L, f, L_interp);
g_interp = interp1(L, g, L_interp);
t_interp = interp1(L, t, L_interp);

end