% Plane change case to assess performance of penalty term

%% Problem Definition
cfg.y0 = [20000e3; 0.5; 0; 1; 0; 0];
cfg.y_target = [20000e3; 0.5; 0; -1; 0];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode89;
cfg.t_span = [0, 1e8];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 5e-3;
cfg.guidance_weights = [1; 1; 1; 1; 1];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 1;
cfg.kappa = deg2rad(64);
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);