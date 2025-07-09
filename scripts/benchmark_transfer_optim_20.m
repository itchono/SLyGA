%% Description
% Version of benchmark transfer with optimized weights

%% Problem Definition
% Create a struct for neatness
cfg.y0 = [20000e3; 0.5; -0.2; 0.5; 0; 0];
cfg.y_target = [25000e3; 0.2; 0.5; 0; 0.3];
cfg.propulsion_model = @sail_thrust;
cfg.steering_law = @quail;
cfg.solver = @ode45;
cfg.t_span = [0, 5e8];
cfg.options = odeset('RelTol', 1e-6, "Stats", "on", "MaxStep", 1e4);
cfg.tol = 1e-2;
cfg.guidance_weights = [ 8.27361944;  1.26638055;  1.623574;  4.13609114;
            6.02322517];
cfg.penalty_param = 1;
cfg.min_pe = 10000e3;
cfg.penalty_weight = 0;
cfg.kappa = deg2rad(55.51);
cfg.dynamics = "mee";
cfg.j2 = false;

%% Run
[~, cfg.casename, ~] = fileparts(mfilename);
[y, t, dv] = run_mission(cfg);
