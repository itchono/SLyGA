%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
mission_cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode113;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-6);
mission_cfg.tol = 1e-3;

% Set a "MaxStep" of about 1e4 if you're using ode89 or ode78

%% Run
print_cfg_summary(mission_cfg) % print out mission info
[y, t, dv] = run_mission(mission_cfg);
print_mission_summary(y, t, dv, mission_cfg)

fprintf("Press `enter` to show plots...\n")
pause

%% Plot
hf1 = figure;
plot_elements(y, t, mission_cfg.y_target);
saveas(hf1, 'slyga_elements.pdf')

hf2 = figure;
plot_steering_history(y, t, mission_cfg.y_target);
saveas(hf2, 'slyga_steering.pdf')

hf3 = figure;
[y_interp, t_interp] = interp_mee(y, t, 100);
plot_orbit_mee(y_interp);
exportgraphics(hf3, 'slyga_orbit_plot.png', 'Resolution', 300)

%% Video
plot_osculating_mee(y);