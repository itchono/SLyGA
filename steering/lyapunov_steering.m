function [alpha, beta] = lyapunov_steering(t, y, y_tgt)
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

[p, f, g, h, k, L] = unpack_mee(y);
p_hat = y_tgt(1);
f_hat = y_tgt(2);
g_hat = y_tgt(3);
h_hat = y_tgt(4);
k_hat = y_tgt(5);

q = 1 + f * sin(L) + g * cos(L);

% SCALING: p by earth radius
D1 = 2 * (p - p_hat) / 6378e3 ...
    +(f - f_hat) * ((q + 1) / q * cos(L) + f / q) ...
    +(g - g_hat) * ((q + 1) / q * sin(L) + g / q);
D2 = (f - f_hat) * sin(L) - (g - g_hat) * cos(L);
D3 = -g/q * (f-f_hat) * (h*sin(L) - k*cos(L)) + f/q * (g-g_hat) * (h*sin(L) - k*cos(L)) + 2 * (h-h_hat) + 2*(k-k_hat);

% Optimal steering angle
alpha_opt = atan2(-D2, -D1);
beta_opt = atan(-D3 / sqrt(D1.^2 + D2.^2));

% Filtered steering angle
[alpha, beta] = cone_angle_filter(t, y, alpha_opt, beta_opt);

end