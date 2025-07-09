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
p = y(1);
p_tgt = cfg.y_target(1);
a = p / (1-(y(2)^2 + y(3)^2));
a_tgt = p_tgt / (1-(cfg.y_target(2)^2 + cfg.y_target(3)^2));

s_p = sqrt(1 + ((a-a_tgt) / (3 * a_tgt)).^4);
S = [s_p; 1; 1; 1; 1];

d_oe_max = approxmaxroc(y);
oe = y(1:5);
oe_hat = cfg.y_target;

% Calculate penalty and "classic" components separately
[P, dPdoe] = penalty(y, cfg.penalty_param, cfg.min_pe);
w_pen = cfg.penalty_weight;
Xi_P = w_pen * dPdoe .* (oe - oe_hat).^2 ./ d_oe_max.^2;
Xi_Q = (oe - oe_hat) ./ d_oe_max.^2;
Xi_R = -(oe - oe_hat).^2 ./ d_oe_max.^3 .* doexxdoe(y);
Xi = Xi_P + 2 .* (1 + w_pen * P) .* (Xi_Q + Xi_R);

W = cfg.guidance_weights;

% Bring together the components
A = A(1:5, :);
D = A.' * (W .* S .* Xi);

% Optimal steering angles)
alpha = atan2(-D(1), -D(2));
beta = atan2(-D(3), norm(D(1:2))); % atan2 for stability (0/0 case)

end