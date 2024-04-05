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
% filesystem
[~, ~, ~] = mkdir("outputs");
mkdir(fullfile("outputs", cfg.casename));

% Write config
exportable_cfg = cfg;
exportable_cfg.propulsion_model = func2str(exportable_cfg.propulsion_model);
exportable_cfg.steering_law = func2str(exportable_cfg.steering_law);
exportable_cfg.solver = func2str(exportable_cfg.solver);
writestruct(exportable_cfg, fullfile("outputs", cfg.casename, 'mission_config.xml'))

% printout
fprintf(" ________  ___           ___    ___ ________  ________     \n|\\   ____\\|\\  \\         |\\  \\  /  /|\\   ____\\|\\   __  \\    \n\\ \\  \\___|\\ \\  \\        \\ \\  \\/  / | \\  \\___|\\ \\  \\|\\  \\   \n \\ \\_____  \\ \\  \\        \\ \\    / / \\ \\  \\  __\\ \\   __  \\  \n  \\|____|\\  \\ \\  \\____    \\/  /  /   \\ \\  \\|\\  \\ \\  \\ \\  \\ \n    ____\\_\\  \\ \\_______\\__/  / /      \\ \\_______\\ \\__\\ \\__\\\n   |\\_________\\|_______|\\___/ /        \\|_______|\\|__|\\|__|\n   \\|_________|        \\|___|/                             \nBEGIN RUN\n")
print_cfg_summary(cfg) % print out mission info

% Set up termination conditions
if cfg.dynamics == "cartesian"
    options = odeset(cfg.options, 'Events', @(t, y) cartesian_convergence(t, y, cfg));
    % No scaling for Cartesian
    ode = @(t, y) dyn_cartesian(t, y, cfg);
    % Convert to Cartesian
    cfg.y0 = mee2cartesian(cfg.y0);
else
    options = odeset(cfg.options, 'Events', @(t, y) mee_convergence(t, y, cfg));
    cfg.y0 = [cfg.y0(1) / 6378e3; cfg.y0(2:end)];
    % Scale initial conditions for MEE
    ode = @(t, y) dyn_mee(t, y, cfg);
end

%% Run
tic;
[t, y_raw] = cfg.solver(ode, cfg.t_span, [cfg.y0; 0], options);

% post-processing scaling and reprocessing
y = y_raw(:, 1:6)';
if cfg.dynamics == "cartesian"
    % convert to MEE
    y(1:6, :) = cartesian2mee(y(1:6, :));
else
    % rescale MEE
    y(1, :) = y(1, :) * 6378e3;
end
dv = y_raw(:, 7);


%% Post-run
time_elapsed = toc;
print_mission_summary(y, t, dv, cfg, time_elapsed)

end

function [value, isterminal, direction] = mee_convergence(~, y, cfg)
% Determines if the orbital parameters are within TOL L2 norm of the
% target
y(1) = y(1) * 6378e3;
value = steering_loss(y, cfg.y_target, cfg.guidance_weights) - cfg.tol;
isterminal = 1;
direction = 0;
end

function [value, isterminal, direction] = cartesian_convergence(~, y, cfg)
y_mee = cartesian2mee(y);

value = steering_loss(y_mee, cfg.y_target, cfg.guidance_weights) - cfg.tol;
isterminal = 1;
direction = 0;
end
