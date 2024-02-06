%% Description
% Somewhat difficult case
%

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [42164e3; 1e-6; 0; 0; 0; 0];
cfg.y_target = [42464e3; 1e-6; 0; 0; 0];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @lyapunov_steering;
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
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);
