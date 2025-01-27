function [alpha, beta] = q_law(t, y, cfg)
% Q_LAW  Steering law for Lyapunov control WITH PENALTY
%
%   [alpha, beta] = q_law(t, y, y_tgt)
%
% Inputs:
%   t = current time
%   y = current state
%   y_tgt = target state
%
% Outputs:
%   [alpha, beta] = steering angles

% scalings
[A, ~, ~] = gve_coeffs(y);
d_oe_max = approxmaxroc(y);
oe = y(1:5);
oe_hat = cfg.y_target;

% Calculate penalty and "classic" components separately
[P, dPdoe] = penalty(y, cfg.penalty_param, cfg.min_pe);
w_pen = cfg.penalty_weight;
Xi_P = w_pen * dPdoe .* (oe - oe_hat).^2 ./ d_oe_max.^2;
Xi_Q = (oe - oe_hat) ./ d_oe_max.^2;
Xi_R = (oe - oe_hat).^2 ./ d_oe_max.^3 .* doexxdoe(y);

W = cfg.guidance_weights;

% Bring together the components
A = A(1:5, :);
D = A.' * (W .* (Xi_P + 2 .* (1 + w_pen * P) .* (Xi_Q + Xi_R)));

% Optimal steering angles)
alpha = atan2(-D(1), -D(2));
beta = atan2(-D(3), norm(D(1:2))); % atan2 for stability (0/0 case)

end