%% Description
% Version of benchmark transfer with optimized weights

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode89;
cfg.t_span = [0, 1e8];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 1e-2;
cfg.guidance_weights = [ 6.827e-01;  9.304e-01;  1.111e+00;  3.386e+00;
        	8.306e+00 ];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 0;
cfg.kappa = deg2rad(62.51);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);
