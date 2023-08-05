function cart = meo2cartesian(p, f, g, L)
% cart = meo2CARTESIAN(p, f, g, L) converts modified equinoctial
% elements to Cartesian coordinates
%
% Works for vectorized inputs as well, but the inputs should be rows

% get eccentricity
e = sqrt(f.^2 + g.^2);

% get true anomaly
theta = L - atan2(g, f);

% get radius and perifocal radius
radius = p ./ (1 + e .* cos(theta));

% to get cartesian position, simply put L for the angle (true longitude
% is true!)
cart = [radius .* cos(L); radius .* sin(L)];
end