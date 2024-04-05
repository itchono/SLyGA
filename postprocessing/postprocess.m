% Make sure everything is in workspace before this runs
casename = cfg.casename;

%% Figures
hf1 = figure;
plot_elements_mee(y, t, cfg.y_target);
exportgraphics(hf1, fullfile("outputs", casename, 'orbital_elements.pdf'), 'ContentType', 'vector')

hf2 = figure;
plot_elements_ke(y, t, cfg.y_target);
exportgraphics(hf2, fullfile("outputs", casename, 'orbital_elements_ke.pdf'), 'ContentType', 'vector')

% Split up plots
hf3 = figure;
plot_steering_history(y, t, cfg);
exportgraphics(hf3, fullfile("outputs", casename, 'steering_history.pdf'), 'ContentType', 'vector')

hf4 = figure;
[y_interp, ~] = interp_mee(y, t, 100);
plot_orbit_mee(y_interp);
exportgraphics(hf4, fullfile("outputs", casename, 'trajectory_plot.png'), ...
    'Resolution', 300)

%% Video
anim_osculating_mee(y, fullfile("outputs", casename, 'trajectory_animation.mp4'));