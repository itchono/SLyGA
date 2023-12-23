function [A, b, q] = gve_coeffs(y)
% GVE_COEFFS  Gauss variational matrices in modified equinoctial elements
%   Inputs:
%       y       State vector (modified equinoctial elements)
%   Outputs:
%       A
%       b
%       q
%       such that y' = A*y + b
%       q is a nice shorthand

[p, f, g, h, k, L] = unpack_mee(y);

% Shorthands
q = 1 + f .* cos(L) + g .* sin(L);
mu = 3.986e14;

% Implement differential equation
leading_coeff = 1 ./ q .* sqrt(p./mu);
dp = [0, 2 .* p, 0];
df = [q .* sin(L), (q + 1) .* cos(L) + f, -g .* (h .* sin(L) - k .* cos(L))];
dg = [-q .* cos(L), (q + 1) .* sin(L) + g, f .* (h .* sin(L) - k .* cos(L))];
dh = [0, 0, cos(L) / 2 .* (1 + h.^2 + k.^2)];
dk = [0, 0, sin(L) / 2 .* (1 + h.^2 + k.^2)];
dL = [0, 0, h .* sin(L) - k .* cos(L)];

A = leading_coeff * [dp; df; dg; dh; dk; dL];
b = [0; 0; 0; 0; 0; q.^2 .* sqrt(mu.*p) ./ p.^2];
end