function [alpha, beta] = lyapunov_steering(~, y, y_tgt, weights)
% LYAPUNOV_STEERING  Steering law for Lyapunov control
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
    weights = ones(5, 1);
end

%% 1) Unpack and Preprocess
[p, f, g, h, k, ~] = unpack_mee(y);
p_hat = y_tgt(1);
f_hat = y_tgt(2);
g_hat = y_tgt(3);
h_hat = y_tgt(4);
k_hat = y_tgt(5);
[A, ~, q] = gve_coeffs(y);
mu = 3.986e14;

%% 2) Calculate Useful Terms
% (Maxima should actually be multiplied bfo 1/F_max, which cancels out
% during the next phase) [this might change once I go quadratic]
d_p_max = 2 .* p ./ q .* sqrt(p./mu);
d_f_max = 2 .* sqrt(p./mu);
d_g_max = 2 .* sqrt(p./mu);
d_h_max = 1/2 .* sqrt(p./mu) .* (1+h.^2+k.^2) ./ (sqrt(1-g.^2) + f);
d_k_max = 1/2 .* sqrt(p./mu) .* (1+h.^2+k.^2) ./ (sqrt(1-f.^2) + g);

max_mats = [d_p_max; d_f_max; d_g_max; d_h_max; d_k_max] ./ thrust_magnitude;
oe = [p; f; g; h; k];
oe_hat = [p_hat; f_hat; g_hat; h_hat; k_hat];

A(1, :) = A(1, :) ./ 6378e3;

% cross-terms in gamma
gamma = 2 .* (oe - oe_hat) ./ max_mats .* weights .* A(1:5, :);
% Be careful on ordering; GVEs are in r,t,n, but D1, D2, D3 are in t,r,n
D = sum(gamma, 1);
D1 = D(2);
D2 = D(1);
D3 = D(3);

% Optimal steering angles)
alpha = atan2(-D2, -D1);
beta = atan2(-D3, sqrt(D1.^2+D2.^2));  % atan2 for stability (0/0 case)

end