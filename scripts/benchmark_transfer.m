%% Description
% Benchmark transfer case between two orbits which are very "far" apart
% Supposed to be a worst-case for the guidance law
% As of the latest version, we get a performance of 874 revolutions, and
% about 6.7 km/s of delta-v expenditure using the unpenalized law
% to within a tolerance of 1e-3; somewhat sesitive to NDF angles

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode89;
cfg.t_span = [0, 1e8];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 1e-3;
cfg.guidance_weights = [1; 1; 1; 1; 1];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 0;
cfg.kappa = deg2rad(64);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);
