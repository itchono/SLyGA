function gamma = lyapunov_steering(t, y, y_tgt)
[p, f, g, L] = unpack_meo(y);
p_hat = y_tgt(1);
f_hat = y_tgt(2);
g_hat = y_tgt(3);

q = 1 + f * sin(L) + g * cos(L);

% SCALING: add in 1/p term so that it normalizes properly
D1 = 2 * (p-p_hat) / p ...
    + (f-f_hat) * ((q+1)/q * cos(L) + f/q) ...
    + (g-g_hat) * ((q+1)/q * sin(L) + g/q);
D2 = (f-f_hat) * sin(L) - (g-g_hat) * cos(L);

% Optimal steering angle
gamma_candidate = atan2(-D2, -D1);

% Calculate resultant cone angle
phi_sun = sun_angle(t);
alpha = L - pi/2 - gamma_candidate - phi_sun;

% If cone angle would result in negative thrust, produce zero thrust
% instead
if cos(alpha) < 0
    % Point sail edge-on to produce ZERO THRUST
    gamma = L - phi_sun;
else
    gamma = gamma_candidate;
end

end