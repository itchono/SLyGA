function [y, t, dv] = run_mission(cfg)
% RUN_MISSION
%
%   RUN_MISSION(cfg)
%
%   Runs a SLyGA sim. The initial and target states are given in MEE.
%
%   cfg is a struct with the following fields:
%       - y0: initial state (MEE)
%       - y_target: target state (MEE)
%       - propulsion_model: model of the propulsion system
%       - steering_law: steering law
%       - solver: ode solver (e.g. @ode45)
%       - t_span: time span (s)
%       - options: options for the ode solver
%       (plus more weights for guidance law and tuning)
%
%   Outputs:
%       - y: (6, N) array of
%           - p: semi-latus rectum (m)
%           - f: f-eccentricity
%           - g: g-eccentricity
%           - h: h-parameter
%           - k: k-parameter
%           - L: true longitude (rad)
%       - t: time (s)
%       - dv: delta-v expended (m/s)
%

%% Pre-Run
fprintf(" ________  ___           ___    ___ ________  ________     \n|\\   ____\\|\\  \\         |\\  \\  /  /|\\   ____\\|\\   __  \\    \n\\ \\  \\___|\\ \\  \\        \\ \\  \\/  / | \\  \\___|\\ \\  \\|\\  \\   \n \\ \\_____  \\ \\  \\        \\ \\    / / \\ \\  \\  __\\ \\   __  \\  \n  \\|____|\\  \\ \\  \\____    \\/  /  /   \\ \\  \\|\\  \\ \\  \\ \\  \\ \n    ____\\_\\  \\ \\_______\\__/  / /      \\ \\_______\\ \\__\\ \\__\\\n   |\\_________\\|_______|\\___/ /        \\|_______|\\|__|\\|__|\n   \\|_________|        \\|___|/                             \nBEGIN RUN\n")
print_cfg_summary(cfg) % print out mission info

% Set up termination conditions
options = odeset(cfg.options, 'Events', @(t, y) mee_convergence(t, y, cfg));

% Scale initial conditions
cfg.y0 = [cfg.y0(1) / 6378e3; cfg.y0(2:end)];

%% Run
ode = @(t, y) slyga_ode(t, y, cfg);
[t, y_raw] = cfg.solver(ode, cfg.t_span, [cfg.y0; 0], options);

% post-processing scaling and reprocessing
y = y_raw(:, 1:6)';
y(1, :) = y(1, :) * 6378e3;
dv = y_raw(:, 7);

%% Post-run
print_mission_summary(y, t, dv, cfg)

end

function yp = slyga_ode(t, y, cfg)
% SLYGA_ODE governinig ODE for SLyGA Simulations
%   YP = SLYGA_ODE(T, Y, CFG) returns
%   the time derivative in modified equinoctial elements for the state
%   vector Y at time T.

%   State is 7x1, 6 for orbital elements and 1 for dv

% Scaling, for error tolerance only (guidance law does scaling internally,
% so we feed it in the unscaled values)
y = [y(1) * 6378e3; y(2:end)];

% GNC
[alpha, beta] = cfg.steering_law(t, y, cfg);

% Adjust targeted steering angle if needed
if func2str(cfg.propulsion_model) == "sail_thrust"
    [alpha, beta] = ndf_heuristic(t, y, alpha, beta);
end

% Propulsion
acceleration = cfg.propulsion_model(t, y, alpha, beta);

% Dynamics
yp = [gve_mee(y, acceleration); norm(acceleration)];
yp(1) = yp(1) / 6378e3;

end

function [value, isterminal, direction] = mee_convergence(~, y, cfg)
% Determines if the orbital parameters are within TOL L2 norm of the
% target
y(1) = y(1) * 6378e3;
value = steering_loss(y, cfg.y_target, cfg.guidance_weights) - cfg.tol;
isterminal = 1;
direction = 0;
end
