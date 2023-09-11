function plot_orbit_mee(p, f, g, L)
% plot_orbit_mee(p, f, g, L, t) plots an orbit in modified equinoctial
% elements. The arguments may be vectorized, but they must be rows if this
% is the case.
%
% Plots the Earth at (0, 0)
%
% Colours based on orbit number

%% Data processing
orbit_number = floor(L / (2*pi));

% convert position to Cartesian
pos = mee2cartesian(p, f, g, L);

% plot the "earth" and the orbit
plot_circle(0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

x = pos(1, :);
y = pos(2, :);
z = zeros(size(x));

% hack to plot a coloured line
% https://www.mathworks.com/matlabcentral/answers/5042-how-do-i-vary-color-along-a-2d-line#answer_7057
surface([x; x], [y; y], [z; z], [orbit_number; orbit_number], ...
    'facecol', 'none', ...
    'edgecol', 'interp');
axis equal;
title("Earth Inertial Coordinates");
xlabel("x (m)")
ylabel("y (m)")
cbar = colorbar;
% Try setting maximum timestep; if it doesn't work then silently skip
try
    set(cbar, 'Ticks', sort([max(cbar.Limits), cbar.Ticks]))
end

ylabel(cbar, "Orbit Number")
end
