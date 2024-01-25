function [alpha, beta] = lyapunov_steering(t, y, cfg)
% LYAPUNOV_STEERING  Steering law for Lyapunov control WITH PENALTY
%
%   [alpha, beta] = lyapunov_steering(t, y, y_tgt)
%
% Inputs:
%   t = current time
%   y = current state
%   y_tgt = target state
%
% Outputs:
%   [alpha, beta] = steering angles

% scalings
S = [1 ./ 6378e3; 1; 1; 1; 1];
[A, ~, ~] = gve_coeffs(y);
d_oe_max = approxmaxroc(y);
oe = y(1:5);
oe_hat = cfg.y_target;

% Calculate penalty and "classic" components separately
[P, dPdoe] = penalty(y, cfg.penalty_param, cfg.min_pe);
Xi_P = dPdoe .* ((oe - oe_hat) ./ d_oe_max).^2;
Xi_E = 2 .* (oe - oe_hat) ./ d_oe_max;
w_p = cfg.penalty_weight;

% Bring together the components
A = A(1:5, :);
D = A.' * (cfg.guidance_weights .* S .* (w_p * Xi_P + (1 + w_p * P) .* Xi_E));

% Optimal steering angles)
alpha = atan2(-D(1), -D(2));
beta = atan2(-D(3), norm(D(1:2))); % atan2 for stability (0/0 case)

end