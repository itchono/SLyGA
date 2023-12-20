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

% Calculate penalty and "classic" components separately
[P, dPdoe] = penalty(y, 1, 10000e3);
Xi_penalty = dPdoe .* ((oe - oe_hat) ./ d_oe_max).^2;
Xi_classic = 2 .* (oe - oe_hat) ./ d_oe_max;

% Bring together the components
d_oe_d_F = A(1:5, :);
Xi = weights .* S .* (Xi_penalty + (1+P) .* Xi_classic);

d_Gamma_d_F = d_oe_d_F.' * Xi;

% Be careful on ordering; GVEs are in r,t,n, but D1, D2, D3 are in t,r,n
D1 = d_Gamma_d_F(2);
D2 = d_Gamma_d_F(1);
D3 = d_Gamma_d_F(3);

% Optimal steering angles)
alpha = atan2(-D2, -D1);
beta = atan2(-D3, sqrt(D1.^2+D2.^2));  % atan2 for stability (0/0 case)

end