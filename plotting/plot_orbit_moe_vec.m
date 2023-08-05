function plot_orbit_moe_vec(t, y, interp_interval)
% plot_orbit_moe_vec(t, y, interp_interval) plots y as a matrix of modified
% equinoctial elements in time. Automatically reformats y to be of shape 
% (4, n) instead of (n, 4) if it is passed in as such. Useful for the 
% output of odeXX. Performs interpolation at interp_interval seconds,
% defaulting to no interpolation

% Reorient the matrix if needed
y_size = size(y);
if y_size(1) > y_size(2)
    y = y';
end

% Interpolate, if interp_interval was passed in
if nargin == 3
    t_series = 0:interp_interval:t(end);
    y = interp1(t, y', t_series)';
end


% Extract orbital elements
p = y(1, :);
f = y(2, :);
g = y(3, :);
L = y(4, :);

plot_orbit_moe(p, f, g, L)

end