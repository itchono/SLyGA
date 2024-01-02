%% Description
% Oguri case G

%% Problem Definition
sma_i = 24505.9e3;
e_i = 0.725;
i_i = 7.05;
Omega_i = 0;
omega_i = 0;

sma_f = 42165e3;
e_f = 0;
i_f = 90;
Omega_f = -90;
omega_f = 0;

% Create a struct for neatness
mission_cfg.y0 = [sma_i * (1 - e_i^2); e_i; 0; 0; 0; 0];
mission_cfg.y_target = [sma_f * (1 - e_f^2); 0; e_f; 0; -1];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
mission_cfg.tol = 3e-2;
mission_cfg.guidance_weights = [8.95875083; 2.13158038; 1.72204813; 3.55941979; 9.78829853];
mission_cfg.penalty_param = 5;
mission_cfg.min_pe = 6878e3;
mission_cfg.penalty_weight = 1;
mission_cfg.kappa_d = deg2rad(64);
mission_cfg.kappa_f = deg2rad(91);
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
[~, mission_cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(mission_cfg);