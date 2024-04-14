%% Description
% Video demo

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [10000e3; 0.2; -0.5; 0; 0; 0];
cfg.y_target = [10000e3; 0.5; 0.2; 0; 0];
cfg.propulsion_model = @constant_thrust;
cfg.steering_law = @q_law;
cfg.solver = @ode89;
cfg.t_span = [0, 1e7];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 5e-3;
cfg.guidance_weights = [1; 1; 1; 1; 1];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 0;
cfg.kappa_d = deg2rad(90);
cfg.kappa_f = deg2rad(91);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);

imseq_osculating_mee(y, "anim", 2)