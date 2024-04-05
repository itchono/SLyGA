%% Description
% two leg mission for better convergence?

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @lyapunov_steering;
cfg.solver = @ode89;
cfg.t_span = [0, 1e8];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 1e-3;
cfg.guidance_weights = [1; 1; 1; 1; 1];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 0;
cfg.kappa_d = deg2rad(64);
cfg.kappa_f = deg2rad(91);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run 1
cfg.casename = "twoleg_1";
[y1, t1, dv1] = run_mission(cfg);

%% Modify for second run
cfg.y0 = y1(:, end);
cfg.t_span = [t1(end), t1(end)+1e7];
cfg.solver = @ode15s;
cfg.tol = 1e-6;
cfg.options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8, "Stats", "on", "MaxStep", 1e3);
cfg.casename = "twoleg_2";

%% Run 2
[y2, t2, dv2] = run_mission(cfg);

%% Merge
y = [y1 y2(:, 2:end)];
t = [t1; t2(2:end)];
dv = [dv1; dv2(2:end)];


%% Postprocess hacks
%eval_last_step(y2, t2, cfg);
%t = t2;
%y = y2;
% postprocess
