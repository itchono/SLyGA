function illumination = calculate_eclipsed(t, y)
% CALCULATE_ECLIPSED  determine if eclipsed from state and time

[p, f, g, h, k, L] = unpack_mee(y);

r_spacecraft_i = mee2cartesian(p, f, g, h, k, L);

[r_sun_i, ~] = sun_position(t);
illumination = ~in_eclipse(r_spacecraft_i, r_sun_i, 6378e3);

end