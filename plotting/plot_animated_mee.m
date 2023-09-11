function plot_animated_mee(p, f, g, L)
% convert position to Cartesian
pos = mee2cartesian(p, f, g, L);

% plot the "earth" and the orbit
plot_circle(0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

x = pos(1, :);
y = pos(2, :);

axis equal;
title("Earth Inertial Coordinates");
xlabel("x (m)")
ylabel("y (m)")
comet(x, y);

end