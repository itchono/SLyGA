function acc_lvlh = J2_perturbation(y)
% J2_PERTURBATION  J2 Perturbation acceleration (Earth)

J2 = 1.08262668e-3;
Re = 6378e3;
mu = 3.986e14;

[p, f, g, h, k, L] = unpack_mee(y);

q = 1 + f .* cos(L) + g .* sin(L);

r = p/q;

prefactor = -3 .* mu .* J2 * Re.^2 ./ r.^4;

acc_lvlh = prefactor * [
    1/2 * (1-12*(h*sin(L) - k*cos(L))^2 / (1 + h.^2 + k.^2).^2);
    4 * (h*sin(L) - k*cos(L)) * (h*cos(L) + k*sin(L)) / (1 + h.^2 + k.^2).^2;
    2 * (1-h^2-k^2) * (h*sin(L) - k*cos(L)) / (1 + h.^2 + k.^2).^2;
    ];
end
