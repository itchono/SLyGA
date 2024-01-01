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
mission_cfg.y0 =        [sma_i * (1-e_i^2); e_i; 0; 0; 0; 0];
mission_cfg.y_target =  [sma_f * (1-e_f^2); 0;  e_f;  0; -1];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-4, "Stats","on", "MaxStep", 1e4);
mission_cfg.tol = 5e-3;
mission_cfg.guidance_weights = [1; 1; 1; 1; 1];
mission_cfg.penalty_param = 1;  % kicking this too high causes big issues
mission_cfg.min_pe = 6878e3;
mission_cfg.penalty_weight = 0;
mission_cfg.kappa_d = deg2rad(64);
mission_cfg.kappa_f = deg2rad(91);
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
[~, casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(mission_cfg);