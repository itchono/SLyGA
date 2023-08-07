function yp = gnc_stack(t, y)

[p, f, g, L] = unpack_meo(y);

% Guidance strategy
eff_angle = mod(L - sun_angle(t), 2*pi);

% only thrust while Sun is up
if (eff_angle > 0) && (eff_angle < pi)
    gamma = 0;
else
    gamma = pi/2;
end


yp = eom_gve_meo(t, y, sail_thrust(t, y, gamma));

end
