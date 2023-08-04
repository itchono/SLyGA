function plot_orbit_moe(p, f, g, L)
% plot_orbit_moe(p, f, g, L) plots an orbit in modified equinoctial
% elements. The arguments may be vectorized, but they must be rows if this
% is the case.
% 
% Plots the Earth at (0, 0)

% convert position to Cartesian
pos = moe2cartesian(p, f, g, L);

% plot the "earth" and the orbit
plot(pos(1, :), pos(2, :), "g", 0, 0, "bo");
axis equal;
title("Earth Inertial Coordinates");

end



