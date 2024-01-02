%% Description
% Version of benchmark transfer with optimized weights

%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 =        [20000e3; 0.5; -0.2; 0.5; 0; 0];
mission_cfg.y_target =  [25000e3; 0.2;  0.5;  0; 0.3];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-4, "Stats","on", "MaxStep", 1e4);
mission_cfg.tol = 5e-3;
mission_cfg.guidance_weights = [ 1.774e+00;  5.149e-01;  3.327e-01;  9.925e+00;  5.317e-01];
mission_cfg.penalty_param = 1;
mission_cfg.min_pe = 10000e3;
mission_cfg.penalty_weight = 0;
mission_cfg.kappa_d = deg2rad(64);
mission_cfg.kappa_f = deg2rad(91);
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
[~, casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(mission_cfg);


