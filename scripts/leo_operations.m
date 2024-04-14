%% Description
% LEO orbit to show off J2 and eclipse

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [6878e3; 0.1; -0.1; 0.5; 0; 0];
cfg.y_target = [7500e3; 0; 0; 0; 0.2];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode89;
cfg.t_span = [0, 1e8];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 5e-2;
cfg.guidance_weights = [1; 1; 1; 1; 1];
cfg.penalty_param = 1;
cfg.min_pe = 6878e3;
cfg.penalty_weight = 2;
cfg.kappa_d = deg2rad(64);
cfg.kappa_f = deg2rad(91);
cfg.dynamics = "mee";
cfg.j2 = true;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);
