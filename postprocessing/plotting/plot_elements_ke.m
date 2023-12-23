function plot_elements_ke(y, t, y_target)
[p, f, g, h, k, L] = unpack_mee(y);
[a, e, i, Omega, omega, theta] = mee2keplerian(p, f, g, h, k, L);

ra = a .* (1+e);
rp = a .* (1-e);

% Plots orbital elements in stacked plots
subplot(211)
plot(t/86400, a, "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
hold on
plot(t/86400, ra, "LineWidth", 1);
plot(t/86400, rp, "LineWidth", 1);
legend("SMA", "AP Radius", "PE Radius", "Location", "best")
title("Evolution of Orbital Elements");
ylabel("Radius")
grid

subplot(212)
plot(t/86400, i, "LineWidth", 1)
hold on
plot(t/86400, Omega, "LineWidth", 1)
plot(t/86400, omega,  "LineWidth", 1);
legend("Inc", "\Omega", "\omega", "Location", "best");
ylabel("Orientation")
grid

end