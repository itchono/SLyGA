%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [20000e3; 0; 0; 0.5; 0; 0];
mission_cfg.y_target = [25000e3; 0; 0; 0.6; 0];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode113;
mission_cfg.t_span = [0, 4e7];
mission_cfg.options = odeset('RelTol', 1e-6);

% Set a "MaxStep" of about 1e4 if you're using ode89 or ode78

%% Run
print_cfg_summary(mission_cfg) % print out mission info
[p, f, g, h, k, L, t] = run_mission(mission_cfg);
num_orbits = round(L(end)/(2 * pi));
fprintf("Propagation terminated after %d orbits (%.f seconds) with %d solver steps\n", num_orbits, t(end), length(t));

% get proxy quantities
err = steering_loss([p; f; g; h; k; zeros(1, length(p))], mission_cfg.y_target);

%% Plot
figure
labels = ["p (m)", "f", "g", "h", "k", "Err"];
stackedplot(t/86400, [p; f; g; h; k; err]', "DisplayLabels", labels);
title("Evolution of Orbital Elements");
xlabel("Time since vernal equinox (d)")
grid
saveas(gcf, 'slyga_elements.pdf')

figure
[p_interp, f_interp, g_interp, h_interp, k_interp, L_interp, t_interp] = interp_mee(p, f, g, h, k, L, t, 100);
plot_orbit_mee(p_interp, f_interp, g_interp, h_interp, k_interp, L_interp);
exportgraphics(gcf, 'slyga_orbit_plot.png', 'Resolution', 300)

plot_osculating_mee(p, f, g, h, k, L);