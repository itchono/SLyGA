function Q = func_Q(y, cfg)
% FUNC_Q compute the Q potential function for a given state
%  Q = FUNC_Q(y, cfg) computes the Q potential function for a given state
%
% Inputs:
%  y - state vector (MEE)
%  cfg - configuration struct
%
% Outputs:
%  Q - Q potential function value

[P, ~] = penalty(y, cfg.penalty_param, cfg.min_pe);

% Define terms
S = [1 ./ 6378e3; 1; 1; 1; 1];
d_oe_max = approxmaxroc(y);
oe = y(1:5);
oe_hat = cfg.y_target;
w_p = cfg.penalty_weight;

terms = cfg.guidance_weights .* S .* ((oe - oe_hat) ./ d_oe_max).^2;

Q = (1 + w_p * P) .* sum(terms);

end