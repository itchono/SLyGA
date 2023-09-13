%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
mission_cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode113;
mission_cfg.t_span = [0, 6e7];
mission_cfg.options = odeset('RelTol', 1e-6);
mission_cfg.tol = 1e-3;

% Set a "MaxStep" of about 1e4 if you're using ode89 or ode78

%% Run
print_cfg_summary(mission_cfg) % print out mission info
[p, f, g, h, k, L, t] = run_mission(mission_cfg);
num_orbits = round(L(end)/(2 * pi));
fprintf("Propagation terminated after %d orbits (%.f seconds) with %d solver steps\n", num_orbits, t(end), length(t));

%% Plot
hf1 = figure;
plot_elements(p, f, g, h, k, L, t, mission_cfg.y_target);
saveas(hf1, 'slyga_elements.pdf')

hf2 = figure;
plot_steering_history(p, f, g, h, k, L, t, mission_cfg.y_target);
saveas(hf2, 'slyga_steering.pdf')

hf3 = figure;
[p_interp, f_interp, g_interp, h_interp, k_interp, L_interp, t_interp] = interp_mee(p, f, g, h, k, L, t, 100);
plot_orbit_mee(p_interp, f_interp, g_interp, h_interp, k_interp, L_interp);
exportgraphics(hf3, 'slyga_orbit_plot.png', 'Resolution', 300)

%% Video
plot_osculating_mee(p, f, g, h, k, L);