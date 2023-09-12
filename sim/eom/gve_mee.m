function yp = gve_mee(~, y, f_app)
% GVE_MEE  Gauss variational equations in modified equinoctial elements
%   yp = gve_mee(t, y, f_app) implements the Gauss variational equations
%   in modified equinoctial elements. The equations are implemented as a
%   system of first order differential equations.
%
%   Inputs:
%       t       Time (s)
%       y       State vector (modified equinoctial elements)
%       f_app   Perturbing acceleration (m/s^2)
%
%   Outputs:
%       yp      Derivative of state vector (modified equinoctial elements)

[p, f, g, h, k, L] = unpack_mee(y);

% Shorthands
q = 1 + f * cos(L) + g * sin(L);
mu = 3.986e14;

% Implement differential equation
leading_coeff = 1 ./ q * sqrt(p./mu);
dp = [0, 2 .* p, 0];
df = [q .* sin(L), (q + 1) .* cos(L) + f, -g .* (h.*sin(L) - k.*cos(L))];
dg = [-q .* cos(L), (q + 1) .* sin(L) + g, f .* (h .*sin(L) - k.*cos(L))];
dh = [0, 0, cos(L)/2 .* (1 + h.^2 + k.^2)];
dk = [0, 0, sin(L)/2 .* (1 + h.^2 + k.^2)];
dL = [0, 0, h.*sin(L) - k.*cos(L)];

A = leading_coeff * [dp; df; dg; dh; dk; dL];
b = [0; 0; 0; 0; 0; q.^2 .* sqrt(mu.*p) ./ p.^2];

yp = A * f_app + b;

end