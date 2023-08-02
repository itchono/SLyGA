n = 100;

p = 1;
f = 0.7;
g = 0.1;
L = linspace(0, 2*pi, n);

% vectorized inputs ahahaha
pos = moe2cartesian(p, f, g, L);

% plot the "earth" and the orbit
plot(pos(1, :), pos(2, :), "g", 0, 0, "bo");
axis equal;
title(sprintf("Orbit with p = %0.2f, f = %0.2f, g = %0.2f", p, f, g));






