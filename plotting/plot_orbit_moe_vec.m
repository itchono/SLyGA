function plot_orbit_moe_vec(y)
% plot_orbit_moe_vec(y) plots y as a matrix of modified equinoctial
% elements in time. Automatically reformats y to be of shape (4, n) instead
% of (n, 4) if it is passed in as such. Useful for the output of odeXX.

% Reorient the matrix if needed
y_size = size(y);
if y_size(1) > y_size(2)
    y = y';

p = y(1, :);
f = y(2, :);
g = y(3, :);
L = y(4, :);

plot_orbit_moe(p, f, g, L)

end