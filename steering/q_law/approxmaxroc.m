function maxroc = approxmaxroc(y)
% Approximate maximum rates of change of each element across all steering
% angles and true longitudes, based on Petropoulos' 2004 paper.

[p, f, g, h, k, L] = unpack_mee(y);

% Shorthands
q = 1 + f .* cos(L) + g .* sin(L);
mu = 3.986e14;

d_p_max = 2 .* p ./ q .* sqrt(p./mu);
d_f_max = 2 .* sqrt(p./mu); % APPROX
d_g_max = 2 .* sqrt(p./mu); % APPROX
d_h_max = 1 / 2 .* sqrt(p./mu) .* (1 + h.^2 + k.^2) ./ (sqrt(1-g.^2) + f);
d_k_max = 1 / 2 .* sqrt(p./mu) .* (1 + h.^2 + k.^2) ./ (sqrt(1-f.^2) + g);

maxroc = [d_p_max; d_f_max; d_g_max; d_h_max; d_k_max] ./ thrust_magnitude;
end