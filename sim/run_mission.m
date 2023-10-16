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

% Set up termination conditions
options = odeset(cfg.options, 'Events', @(t, y) mee_convergence(t, y, cfg.y_target, cfg.tol));

ode = @(t, y) slyga_ode(t, y, cfg.y_target, cfg.propulsion_model, cfg.steering_law);
if func2str(cfg.solver) == "ode5"
    t = linspace(cfg.t_span(1), cfg.t_span(2), 1e4);
    y_raw = cfg.solver(ode, t, [cfg.y0; 0]);
else
    [t, y_raw] = cfg.solver(ode, cfg.t_span, [cfg.y0; 0], options);
end

y = y_raw(:, 1:6)';
dv = y_raw(:, 7);

end

function yp = slyga_ode(t, y, y_target, propulsion_model, steering_law)
% SLYGA_ODE governinig ODE for SLyGA Simulations
%   YP = SLYGA_ODE(T, Y, PROPULSION_MODEL, STEERING_LAW, Y_TARGET) returns
%   the time derivative in modified equinoctial elements for the state
%   vector Y at time T. PROPULSION_MODEL is a function handle to the
%   function that computes the thrust acceleration vector. STEERING_LAW is
%   a function handle to the function that computes the steering angle
%   vector. YP is the time derivative of Y. Y_TARGET is the target state (shape [3, 1])

% GNC
[alpha, beta] = steering_law(t, y, y_target);

% Adjust targeted steering angle if needed
if func2str(propulsion_model) == "sail_thrust"
    [alpha, beta] = ndf_heuristic(t, y, alpha, beta);
end

% Propulsion
acceleration = propulsion_model(t, y, alpha, beta);

% Dynamics
yp = [gve_mee(t, y, acceleration); norm(acceleration)];

end

function [value, isterminal, direction] = mee_convergence(~, y, y_target, tol)
% Determines if the orbital parameters are within TOL L2 norm of the
% target
value = steering_loss(y, y_target) - tol;
isterminal = 1;
direction = 0;
end
