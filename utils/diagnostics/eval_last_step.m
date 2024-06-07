function eval_last_step(y, t, cfg, n_eval)
% EVAL_LAST_STEP  Evaluate the last n_eval steps of a simulation
%   eval_last_step(y, t, cfg, n_eval) evaluates the last n_eval steps of a
%   simulation and plots the trends of the MEE derivatives. It also plots
%   the eclipse data.
%
% Inputs:
%   y = state vector
%   t = time vector
%   cfg = configuration struct
%   n_eval = number of steps to evaluate (default: all)

% Used only as a diagnostic tool, not for publication-grade figures

if nargin < 4
    n_eval = length(t);
end

% Set up termination conditions
if cfg.dynamics == "cartesian"
    % No scaling for Cartesian
    ode = @(t, y) dyn_cartesian(t, y, cfg);
    % Convert to Cartesian
    cfg.y0 = mee2cartesian(cfg.y0);
else
    cfg.y0 = [cfg.y0(1) / 6378e3; cfg.y0(2:end)];
    % Scale initial conditions for MEE
    ode = @(t, y) dyn_mee(t, y, cfg);
end

idxs = (length(t)-n_eval+1):length(t);
yp = zeros(5, n_eval);

for i = idxs
    yt = ode(t(i), y(:, i));
    yp(:, i) = abs(yt(1:5));
end
% normalize yp

yp_n = yp ./ max(yp, [], 2);

figure
subplot(311)
plot(t, yp_n.', "LineWidth", 1)
legend("p", "f", "g", "h", "k", "Location", "best")
xlabel("Time (s)")
grid()
title("Derivative Trends (relative to max over interval)")

subplot(313)
plot(yp_n.', "LineWidth", 1)
legend("p", "f", "g", "h", "k", "Location", "best")
xlabel("Step Number")
grid()

%% ECLIPSE CALCS
subplot(312)
[y_interp, t_interp] = interp_mee(y, t);
postmission_data(t_interp, y_interp, cfg);
ylabel("Sunlight (1 or 0)")

figure
subplot(211)
semilogy(t, yp.', "LineWidth", 1)
legend("p", "f", "g", "h", "k", "Location", "best")
xlabel("Time (s)")
grid()
title("Derivative Trends (absolute)")

subplot(212)
semilogy(yp.', "LineWidth", 1)
legend("p", "f", "g", "h", "k", "Location", "best")
xlabel("Step Number")
grid()
end