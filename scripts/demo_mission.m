%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
mission_cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-8, "Stats","on", "MaxStep", 1e4);
mission_cfg.tol = 1e-4;
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
print_cfg_summary(mission_cfg) % print out mission info
[y, t, dv] = run_mission(mission_cfg);
print_mission_summary(y, t, dv, mission_cfg)

%% Plot
fprintf("Press `enter` to show plots...\n")
pause
plot_everything(y, t, mission_cfg.y_target)