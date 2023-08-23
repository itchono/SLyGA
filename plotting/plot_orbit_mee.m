function plot_orbit_mee(p, f, g, L, t)
% plot_orbit_mee(p, f, g, L, t) plots an orbit in modified equinoctial
% elements. The arguments may be vectorized, but they must be rows if this
% is the case.
%
% Plots the Earth at (0, 0)
%
% Accepts an optional time argument for colouring the line, otherwise it
% colours using sample number

% convert position to Cartesian
pos = mee2cartesian(p, f, g, L);

% plot the "earth" and the orbit
plot_circle(0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

x = pos(1, :);
y = pos(2, :);
z = zeros(size(x));

if nargin == 5
    time = t;
else
    time = 1:length(x);
end
% hack to plot a coloured line
% https://www.mathworks.com/matlabcentral/answers/5042-how-do-i-vary-color-along-a-2d-line#answer_7057
surface([x; x], [y; y], [z; z], [time; time], ...
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

if nargin == 5
    ylabel(cbar, "Time (s)")
else
    ylabel(cbar, "Step Number")
end

end
