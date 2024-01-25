function [alpha, beta] = linear_steering(~, y, y_tgt)
% back-solving force vector required to go towards a differential change

[p, f, g, h, k, L] = unpack_mee(y);

scaling_mat = diag([1 / 6378e3; 1; 1; 1; 1]);

% Required diretion to go in
b = -scaling_mat * (y(1:5) - y_tgt);

% Shorthands
q = 1 + f * cos(L) + g * sin(L);
mu = 3.986e14;

% Implement A matrix
leading_coeff = 1 ./ q * sqrt(p./mu);
dp = [0, 2 .* p, 0];
df = [q .* sin(L), (q + 1) .* cos(L) + f, -g .* (h .* sin(L) - k .* cos(L))];
dg = [-q .* cos(L), (q + 1) .* sin(L) + g, f .* (h .* sin(L) - k .* cos(L))];
dh = [0, 0, cos(L) / 2 .* (1 + h.^2 + k.^2)];
dk = [0, 0, sin(L) / 2 .* (1 + h.^2 + k.^2)];

A = scaling_mat * leading_coeff * [dp; df; dg; dh; dk];

% Solve for which way force needs to point
n = A \ b;

[alpha, beta] = lvlh2steering(n/norm(n));

end