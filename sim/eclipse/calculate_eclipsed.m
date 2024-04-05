function illumination = calculate_eclipsed(t, y)
% CALCULATE_ECLIPSED  determine if eclipsed from state and time
r_spacecraft_i = mee2cartesian(y);
r_spacecraft_i = r_spacecraft_i(1:3);

[r_sun_i, ~] = sun_position(t);
illumination = ~in_eclipse(r_spacecraft_i, r_sun_i, 6378e3);

end