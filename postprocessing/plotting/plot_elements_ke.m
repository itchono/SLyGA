function plot_elements_ke(y, t, y_target)
[p, f, g, h, k, L] = unpack_mee(y);
[a, e, i, Omega, omega, ~] = mee2keplerian(p, f, g, h, k, L);

ra = a .* (1 + e);
rp = a .* (1 - e);

days = t/86400;

% size
fh = gcf();
fh.Position(3:4) = [560, 600];

% Plots orbital elements in stacked plots
tiledlayout(2, 1, 'TileSpacing', 'tight');

% Plots orbital elements in stacked plots
ax1 = nexttile;
plot(days, a, "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
hold on
plot(days, ra, "LineWidth", 1);
plot(days, rp, "LineWidth", 1);
legend("SMA", "AP Radius", "PE Radius", "Location", "best")
ylabel("Orbit Size (m)")
grid on
grid minor

ax2 = nexttile;
plot(days, i, "LineWidth", 1)
hold on
plot(days, Omega, "LineWidth", 1)
plot(days, omega, "LineWidth", 1);
legend("i", "\Omega", "\omega", "Location", "best");
ylabel("Orientation (deg)")
grid on
grid minor

xlabel("Elapsed Time (Days)")

% Link x
linkaxes([ax1, ax2],'x')

% Tight xlim and final 
for aa = [ax1, ax2]
    xlim(aa, [min(days), max(days)])
    xticks(aa, [xticks, round(max(days))])
end

% Top label
set(ax1,'XAxisLocation','top')
converted_values = floor(interp1(t, L, xticks*86400, "linear", "extrap") /(2 * pi));
set(ax1, "XTickLabels", converted_values);
xlabel(ax1,'Orbit Number')

end