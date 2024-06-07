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
cfg.y0 = [sma_i * (1 - e_i^2); e_i; 0; 0; 0; 0];
cfg.y_target = [sma_f * (1 - e_f^2); 0; e_f; 0; -1];
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
cfg.kappa = deg2rad(50);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
k_range = 90:-10:10;
tofs = zeros(length(k_range), 1);

for i = 1:length(k_range)
    cfg.kappa = deg2rad(k_range(i));
    [~, t, ~] = run_mission(cfg);
    tofs(i) = t(end);
end