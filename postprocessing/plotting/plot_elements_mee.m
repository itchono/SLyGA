function plot_elements_mee(y, t, y_target)
[p, f, g, h, k, L] = unpack_mee(y);

days = t/86400;

% size
fh = gcf();
fh.Position(3:4) = [560, 600];

% Plots orbital elements in stacked plots
tiledlayout(3, 1, 'TileSpacing', 'tight');

ax1 = nexttile;
plot(days, p, "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
yline(y_target(1), "--", "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
legend("p", "Location", "best")
ylabel("Orbit Size (m)")
grid on
grid minor

ax2 = nexttile;
plot(days, f, "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
hold on
plot(days, g, "Color", [0.4660, 0.6740, 0.1880], "LineWidth", 1)
yline(y_target(2), "--", "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
yline(y_target(3), "--", "Color", [0.4660, 0.6740, 0.1880], "LineWidth", 1)
legend("f", "g", "Location", "best");
ylabel("Eccentricity Vector")
set(gca,'XTickLabel',[]);
grid on
grid minor

ax3 = nexttile;
plot(days, h, "Color", [0.9290, 0.6940, 0.1250], "LineWidth", 1)
hold on
plot(days, k, "Color", [0.4940, 0.1840, 0.5560], "LineWidth", 1);
yline(y_target(4), "--", "Color", [0.9290, 0.6940, 0.1250], "LineWidth", 1)
yline(y_target(5), "--", "Color", [0.4940, 0.1840, 0.5560], "LineWidth", 1)
legend("h", "k", "Location", "best");
ylabel("Nodal Position")
grid on
grid minor

xlabel("Elapsed Time (Days)")

% Link x
linkaxes([ax1, ax2, ax3],'x')

% Tight xlim and final 
for aa = [ax1, ax2, ax3]
    xt = xticks(aa);
    xt(end) = round(max(days));
    xlim(aa, [min(days), max(days)+1])
    xticks(aa, xt);
end

% Top label
set(ax1,'XAxisLocation','top')
converted_values = floor(interp1(t, L, xt*86400, "linear", "extrap") /(2 * pi));
set(ax1, "XTickLabels", converted_values);
xticks(ax1, xt)
xlabel(ax1,'Orbit Number')
end