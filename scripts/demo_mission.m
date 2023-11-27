%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [20000e3; 1e-6; 0; 0; 1; 0];
mission_cfg.y_target = [100000e3; 0; 0; 0; 0];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering_pen;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-4, "Stats","on", "MaxStep", 1e4);
mission_cfg.tol = 5e-3;
mission_cfg.guidance_weights = [1; 0; 0; 0; 0];
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
print_cfg_summary(mission_cfg) % print out mission info
[y, t, dv] = run_mission(mission_cfg);
print_mission_summary(y, t, dv, mission_cfg)

%% Plot
fprintf("Press `enter` to show plots...\n")
pause
plot_everything(y, t, mission_cfg.y_target)