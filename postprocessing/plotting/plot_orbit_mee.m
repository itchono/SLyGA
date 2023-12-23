function plot_orbit_mee(y)
% plot_orbit_mee(y) plots an orbit in modified equinoctial
% elements. The arguments may be vectorized, but they must be rows if this
% is the case (i.e. (6, N))
%
% Plots the Earth at (0, 0)
%
% Colours based on orbit number

%% Data processing
[p, f, g, h, k, L] = unpack_mee(y);

orbit_number = floor(L/(2 * pi));

% convert position to Cartesian
pos = mee2cartesian(p, f, g, h, k, L);

% plot the "earth" and the orbit
plot_sphere(0, 0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

x = pos(1, :);
y = pos(2, :);
z = pos(3, :);

% hack to plot a coloured line
% https://www.mathworks.com/matlabcentral/answers/5042-how-do-i-vary-color-along-a-2d-line#answer_7057
patch([x, nan], [y, nan], [z, nan], [orbit_number, nan], ...
    'facecol', 'none', ...
    'edgecol', 'interp');
title("Earth Inertial Coordinates");
xlabel("x (m)")
ylabel("y (m)")
zlabel("z (m)")
cbar = colorbar;
% Try setting maximum timestep; if it doesn't work then silently skip
try
    set(cbar, 'Ticks', sort([max(cbar.Limits), cbar.Ticks]))
end

ylabel(cbar, "Orbit Number")
axis equal;

view(3)
end
