function yp = eom_gve_meo(~, y, f_app)
[p, f, g, L] = unpack_meo(y);

% Shorthands
q = 1 + f * cos(L) + g * sin(L);
mu = 3.986e14;

% Implement differential equation
leading_coeff = 1/q * sqrt(p/mu);
A = leading_coeff * [0, 2.*p;
    q.*sin(L), (q+1).*cos(L) + f;
    -q.*cos(L), (q+1).*sin(L) + g;
    0, 0];
b = [0; 0; 0; q.^2 .* sqrt(mu .* p) ./ p.^2];

yp = A * f_app + b;
end