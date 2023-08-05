function yp = gnc_stack(t, y)

[p, f, g, L] = unpack_meo(y);

% Guidance strategy
if (mod(L, 2*pi) > pi/6) && (mod(L, 2*pi) < 5*pi/6)
    gamma = 0;
else
    gamma = pi/2;
end


yp = eom_gve_meo(t, y, sail_thrust(t, y, gamma));

end
