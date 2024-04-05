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


% Singularity detection and prevention
if abs(sqrt(1-g.^2) + f) < 1e-12
    d1 = 1e-12 * sign(sqrt(1-g.^2) + f);
    fprintf("Singularity in D1\n")
else
    d1 = (sqrt(1-g.^2) + f);
end

if abs(sqrt(1-f.^2) + g) < 1e-12
    d2 = 1e-12 * sign(sqrt(1-f.^2) + g);
    fprintf("Singularity in D2\n")
else
    d2 = (sqrt(1-f.^2) + g);
end

d_h_max = 1 / 2 .* sqrt(p./mu) .* (1 + h.^2 + k.^2) ./ d1;
d_k_max = 1 / 2 .* sqrt(p./mu) .* (1 + h.^2 + k.^2) ./ d2;

maxroc = [d_p_max; d_f_max; d_g_max; d_h_max; d_k_max] ./ thrust_magnitude;
end