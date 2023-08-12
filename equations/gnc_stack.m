function yp = gnc_stack(t, y)

[p, f, g, L] = unpack_meo(y);

% Guidance
gamma = lyapunov_steering(t, y, [5000e3, 0, 0]);
yp = eom_gve_meo(t, y, sail_thrust(t, y, gamma));

end

