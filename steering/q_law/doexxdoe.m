function derivs = doexxdoe(y)
[p, f, g, h, k, L] = unpack_mee(y);

% Shorthands
q = 1 + f .* cos(L) + g .* sin(L);
mu = 3.986e14;

partial_p = 3./q .* sqrt(p/mu);
partial_h = sqrt(p/mu) .* h ./ (sqrt(1-g.^2) + f);
partial_k = sqrt(p/mu) .* k ./ (sqrt(1-f.^2) + g);

derivs = [partial_p; 0; 0; partial_h; partial_k] .* thrust_magnitude;
end