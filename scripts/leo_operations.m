%% Description
% LEO orbit to show off J2 and eclipse

%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 = [6878e3; 0.01; -0.01; 0.5; 0; 0];
mission_cfg.y_target = [7500e3; 0; 0; 0; 0.2];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
mission_cfg.tol = 5e-2;
mission_cfg.guidance_weights = [1; 1; 1; 1; 1];
mission_cfg.penalty_param = 1;
mission_cfg.min_pe = 6878e3;
mission_cfg.penalty_weight = 2;
mission_cfg.kappa_d = deg2rad(64);
mission_cfg.kappa_f = deg2rad(91);
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
[~, mission_cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(mission_cfg);
