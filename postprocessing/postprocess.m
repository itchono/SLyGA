% Make sure everything is in workspace before this runs

%% Processing
y_target = mission_cfg.y_target;
[~, ~, ~] = mkdir("outputs");
mkdir(fullfile("outputs", casename));

%% Write config
exportable_cfg = mission_cfg;
exportable_cfg.propulsion_model = func2str(exportable_cfg.propulsion_model);
exportable_cfg.steering_law = func2str(exportable_cfg.steering_law);
exportable_cfg.solver = func2str(exportable_cfg.solver);
writestruct(exportable_cfg, fullfile("outputs", casename, 'mission_config.xml'))

%% Figures
hf1 = figure;
plot_elements_mee(y, t, y_target);
saveas(hf1, fullfile("outputs", casename, 'orbital_elements.pdf'))

hf2 = figure;
plot_steering_history(y, t, mission_cfg);
saveas(hf2, fullfile("outputs", casename, 'steering_history.pdf'))

hf3 = figure;
[y_interp, ~] = interp_mee(y, t, 100);
plot_orbit_mee(y_interp);
exportgraphics(hf3, fullfile("outputs", casename, 'trajectory_plot.png'), ...
    'Resolution', 300)

%% Video
plot_osculating_mee(y, fullfile("outputs", casename, 'trajectory_animation.mp4'));