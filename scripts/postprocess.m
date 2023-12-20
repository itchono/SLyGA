% Make sure everything is in workspace before this runs

%% Processing
y_target = mission_cfg.y_target;

%% Figures
hf1 = figure;
plot_elements_mee(y, t, y_target);
saveas(hf1, 'slyga_elements.pdf')

hf2 = figure;
plot_steering_history(y, t, y_target);
saveas(hf2, 'slyga_steering.pdf')

hf3 = figure;
[y_interp, ~] = interp_mee(y, t, 100);
plot_orbit_mee(y_interp);
exportgraphics(hf3, 'slyga_orbit_plot.png', 'Resolution', 300)

%% Video
plot_osculating_mee(y);