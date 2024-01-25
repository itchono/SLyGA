function plot_elements_mee(y, t, y_target)
[p, f, g, h, k, ~] = unpack_mee(y);

% Plots orbital elements in stacked plots
subplot(311)
plot(t/86400, p, "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
yline(y_target(1), "--", "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
legend("p", "Location", "best")
title("Evolution of Orbital Elements");
ylabel("Semi-Latus Rect.")
grid

subplot(312)
plot(t/86400, f, "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
hold on
plot(t/86400, g, "Color", [0.4660, 0.6740, 0.1880], "LineWidth", 1)
yline(y_target(2), "--", "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
yline(y_target(3), "--", "Color", [0.4660, 0.6740, 0.1880], "LineWidth", 1)
legend("f", "g", "Location", "best");
ylabel("Ecc. Vector")
grid

subplot(313)
plot(t/86400, h, "Color", [0.9290, 0.6940, 0.1250], "LineWidth", 1)
hold on
plot(t/86400, k, "Color", [0.4940, 0.1840, 0.5560], "LineWidth", 1);
yline(y_target(4), "--", "Color", [0.9290, 0.6940, 0.1250], "LineWidth", 1)
yline(y_target(5), "--", "Color", [0.4940, 0.1840, 0.5560], "LineWidth", 1)
legend("h", "k", "Location", "best");
ylabel("Nodal Position")
grid

xlabel("Elapsed Time (Days)")

end