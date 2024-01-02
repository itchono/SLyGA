function n = coverstone_maximization(u_i, b_i, n_star_i)
% from coverstone and prussing paper; figure out what to do with this!
% check out Oguri paper and compare how they implemented it

v_alpha = dot(n_star_i, u_i);
v_beta = dot(n_star_i, b_i);

zeta = (-3 * v_alpha - sqrt(9*v_alpha.^2+8*v_beta.^2)) ./ (4 .* v_beta);

n_alpha = -abs(v_beta) / (v_beta .* sqrt(1+zeta.^2));
n_beta = zeta .* n_alpha;

n = [n_alpha; n_beta];
end