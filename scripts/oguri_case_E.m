%% Description
% Oguri case E

%% Problem Definition
sma_i = 24505.9e3;
e_i = 0.725;
i_i = 0.06;
Omega_i = 0;
omega_i = 0;
p_i = sma_i * (1-e_i^2);
f_i = e_i * cosd(Omega_i + omega_i);
g_i = e_i * sind(Omega_i + omega_i);
h_i = tand(i_i/2)*cosd(Omega_i);
k_i = tand(i_i/2)*sind(Omega_i);

sma_f = 26553.0e3;
e_f = 0.727;
i_f = 63.4;
Omega_f = 90;
omega_f = 270;
p_f = sma_f * (1-e_f^2);
f_f = e_f * cosd(Omega_f + omega_f);
g_f = e_f * sind(Omega_f + omega_f);
h_f = tand(i_f/2)*cosd(Omega_f);
k_f = tand(i_f/2)*sind(Omega_f);

% Create a struct for neatness
cfg.y0 = [p_i; f_i; g_i; h_i; k_i; 0];
cfg.y_target = [p_f; f_f; g_f; h_f; k_f];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode89;
cfg.t_span = [0, 1e8];
cfg.options = odeset('RelTol', 1e-4, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 3e-2;
cfg.guidance_weights = [1; 1; 1; 1; 1];
cfg.penalty_param = 5;
cfg.min_pe = 6878e3;
cfg.penalty_weight = 1;
cfg.kappa = deg2rad(64);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);