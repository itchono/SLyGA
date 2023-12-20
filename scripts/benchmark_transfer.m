%% Description
% Benchmark transfer case between two orbits which are very "far" apart
% Supposed to be a worst-case for the guidance law
% As of the latest version, we get a performance of 992 revolutions, and
% about 7 km/s of delta-v expenditure using the unpenalized law

%% Problem Definition
% Create a struct for neatness
mission_cfg.y0 =        [20000e3; 0.5; -0.2; 0.5; 0; 0];
mission_cfg.y_target =  [25000e3; 0.2;  0.5;  0; 0.3];
mission_cfg.propulsion_model = @sail_thrust;
mission_cfg.steering_law = @lyapunov_steering_alt;
mission_cfg.solver = @ode89;
mission_cfg.t_span = [0, 1e8];
mission_cfg.options = odeset('RelTol', 1e-4, "Stats","on", "MaxStep", 1e4);
mission_cfg.tol = 5e-3;
mission_cfg.guidance_weights = [1; 1; 1; 1; 1];
% Set a "MaxStep" of about 1e4 in odeset if you're using ode89 or ode78

%% Run
run_mission(mission_cfg);


