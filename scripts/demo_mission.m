%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [6878e3; 0; 0; 0];
mission_cfg.y_target = [9000e3; 0; 0];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode113;
mission_cfg.t_span = [0, 5e5];
mission_cfg.options = odeset('RelTol',1e-12);


%% Run
[p, f, g, L, t] = run_mission(mission_cfg);

% get proxy quantities
ecc = sqrt(f.^2 + g.^2);
sma = p .* (1-ecc.^2);

%% Plot
figure
labels = ["Semi-Latus Rectum (m)", "Semi-Major Axis (m)", "f (x-eccentricity)", "g (y-eccentricity)"];
stackedplot(t/86400, [p; sma; f; g]', "DisplayLabels", labels);

title("Evolution of Orbital Elements for basic Steering Law");
xlabel("Time since vernal equinox (d)")

figure
plot_orbit_meo_vec(t, [p; f; g; L], 120);