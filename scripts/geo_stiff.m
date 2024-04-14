%% Description
% two leg approach to GEO

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [42164e3; 1e-6; 0; 0; 0; 0];
cfg.y_target = [42464e3; 1e-6; 0; 0; 0];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode89;
cfg.t_span = [0, 1e7];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 5e-3;
cfg.guidance_weights = [5; 0.5; 1; 0; 0];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 0;
cfg.kappa_d = deg2rad(64);
cfg.kappa_f = deg2rad(91);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run 1
cfg.casename = "geo_twoleg_1";
[y1, t1, dv1] = run_mission(cfg);

%% Modify for second run
cfg.y0 = y1(:, end);
cfg.t_span = [t1(end), t1(end)+1e6];
cfg.solver = @ode15s;
cfg.tol = 1e-6;
cfg.guidance_weights = [1; 2; 2; 0; 0];
cfg.options = odeset('RelTol', 1e-6, "Stats", "on", "MaxStep", 1e3);
cfg.casename = "geo_twoleg_2";

%% Run 2
[y2, t2, dv2] = run_mission(cfg);

%% Merge
y = [y1 y2(:, 2:end)];
t = [t1; t2(2:end)];
dv = [dv1; dv2(2:end)];

