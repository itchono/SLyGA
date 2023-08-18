function [p, f, g, L, t] = run_mission(cfg)
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
%       - p: semi-latus rectum (m)
%       - f: f-eccentricity
%       - g: g-eccentricity
%       - L: true longitude (rad)
%       - t: time (s)
%


% Set up termination conditions
options = odeset(cfg.options, 'Events', @(t, y) mee_convergence(t, y, cfg.y_target));

ode = @(t, y) slyga_ode(t, y, cfg.y_target, cfg.propulsion_model, cfg.steering_law);
[t, y] = cfg.solver(ode, cfg.t_span, cfg.y0, options);
[p, f, g, L] = unpack_mee(y');

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
gamma = steering_law(t, y, y_target);

% Propulsion
acceleration = propulsion_model(t, y, gamma);

% Dynamics
yp = gve_mee(t, y, acceleration);

end

function [value, isterminal, direction] = mee_convergence(~,y, y_target)
value = norm(y(1:3) - y_target);
isterminal = 1;
direction = 0;
end
