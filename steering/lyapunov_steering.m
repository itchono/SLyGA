function gamma = lyapunov_steering(t, y, y_tgt)
% LYAPUNOV_STEERING  Steering law for Lyapunov control
%
%   gamma = lyapunov_steering(t, y, y_tgt)
%
% Inputs:
%   t = current time
%   y = current state
%   y_tgt = target state
%
% Outputs:
%   gamma = steering angle

[p, f, g, L] = unpack_mee(y);
p_hat = y_tgt(1);
f_hat = y_tgt(2);
g_hat = y_tgt(3);

q = 1 + f * sin(L) + g * cos(L);

% SCALING: add in 1/p term so that it normalizes properly
D1 = 2 * (p - p_hat) / p ...
    +(f - f_hat) * ((q + 1) / q * cos(L) + f / q) ...
    +(g - g_hat) * ((q + 1) / q * sin(L) + g / q);
D2 = (f - f_hat) * sin(L) - (g - g_hat) * cos(L);

% Optimal steering angle
gamma_opt = atan2(-D2, -D1);

% Filtered steering angle
gamma = cone_angle_filter(t, y, gamma_opt);

end