function [p_interp, f_interp, g_interp, L_interp, t_interp] = interp_mee(p, f, g, L, t, interp_step)
%INTERP_MEE Interpolate MEE elements obtained from propagation to have equal time steps
%   [p_interp, f_interp, g_interp, L_interp, t_interp] = interp_mee(p, f, g, L, t, interp_step)
%  interpolates the MEE elements p, f, g, L obtained from propagation to smooth out the
%  solution, primarily for plotting purposes.
% if interp_step is not specified, it is set to 30 seconds.

if nargin < 6
    interp_step = 30;
end

t_interp = t(1):interp_step:t(end);
p_interp = interp1(t, p, t_interp);
f_interp = interp1(t, f, t_interp);
g_interp = interp1(t, g, t_interp);
L_interp = interp1(t, L, t_interp);

end