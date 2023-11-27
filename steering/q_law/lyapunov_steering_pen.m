function [alpha, beta] = lyapunov_steering_pen(~, y, y_tgt, weights)
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

if nargin < 4
    weights = [1; 1; 1; 1; 1];
end

% scalings
S = [1./6378e3; 1; 1; 1; 1];
[A, ~, ~] = gve_coeffs(y);
d_oe_max = approxmaxroc(y);
oe = y(1:5);
oe_hat = y_tgt;
d_oe = A(1:5, :);

[P, dPdoe] = penalty(y, 1, 10000e3);
Gamma_penalty = dPdoe .* ((oe - oe_hat) ./ d_oe_max).^2 .* d_oe;
Gamma_classic = 2 .* (oe - oe_hat) ./ d_oe_max .* d_oe;

Gamma = weights .* S .* (Gamma_penalty + (1+P) .* Gamma_classic);

% Be careful on ordering; GVEs are in r,t,n, but D1, D2, D3 are in t,r,n
D = sum(Gamma, 1);
D1 = D(2);
D2 = D(1);
D3 = D(3);

% Optimal steering angles)
alpha = atan2(-D2, -D1);
beta = atan2(-D3, sqrt(D1.^2+D2.^2));  % atan2 for stability (0/0 case)

end