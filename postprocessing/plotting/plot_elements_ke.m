function plot_elements_ke(y, t, y_target)
[p, f, g, h, k, L] = unpack_mee(y);
[a, e, i, Omega, omega, ~] = mee2keplerian(p, f, g, h, k, L);
[a_tg, e_tg, i_tg, Omega_tg, omega_tg, ~] = mee2keplerian(y_target(1),...
    y_target(2),y_target(3),y_target(4),y_target(5),0);


ra = a .* (1 + e);
rp = a .* (1 - e);

days = t/86400;

% size
fh = gcf();
fh.Position(3:4) = [560, 600];
fh.Position(2) = 50;

% Plots orbital elements in stacked plots
tiledlayout(3, 1, 'TileSpacing', 'tight');

% Plots orbital elements in stacked plots
ax1 = nexttile;
plot(days, a, "Color", [0, 0.4470, 0.7410], "LineWidth", 1);
yline(a_tg, "--", "Color", [0, 0.4470, 0.7410], "LineWidth", 1)
hold on
plot(days, ra, "LineWidth", 1);
plot(days, rp, "LineWidth", 1);
legend("SMA", "SMA Target", "AP Radius", "PE Radius", "Location", "best")
ylabel("Orbit Size (m)")
grid on
grid minor

ax2 = nexttile;
plot(days, e, "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
hold on
yline(e_tg, "--", "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
legend("e", "e target", "Location", "best");
grid on
grid minor

ax3 = nexttile;
plot(days, i, "Color", [0.9290, 0.6940, 0.1250], "LineWidth", 1)
hold on
yline(i_tg, "--", "Color", [0.9290, 0.6940, 0.1250], "LineWidth", 1)
plot(days, Omega, "Color", [0.4660, 0.6740, 0.1880], "LineWidth", 1)
yline(Omega_tg, "--", "Color", [0.4660, 0.6740, 0.1880], "LineWidth", 1)
plot(days, omega, "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1);
yline(omega_tg, "--", "Color", [0.8500, 0.3250, 0.0980], "LineWidth", 1)
legend("i", "i target", "\Omega", "\Omega target", "\omega",...
    "\omega target", "Location", "best");
ylabel("Orientation (deg)")
grid on
grid minor


xlabel("Elapsed Time (Days)")

% Link x
linkaxes([ax1,ax2, ax3],'x')

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