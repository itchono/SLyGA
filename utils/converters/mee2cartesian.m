function cart = mee2cartesian(p, f, g, L)
% MEE2CARTESIAN converts modified equinoctial elements to cartesian
% coordinates. The inputs should be vectors or scalars, but all should be
% the same size. The outputs will be the same size as the inputs.
%
%   Inputs:
%       p - semilatus rectum (km)
%       f - component of eccentricity vector (km)
%       g - component of eccentricity vector (km)
%       L - true longitude (rad)
%
%   Outputs:
%       cart - cartesian coordinates (km)

% get eccentricity
e = sqrt(f.^2+g.^2);

% get true anomaly
theta = L - atan2(g, f);

% get radius and perifocal radius
radius = p ./ (1 + e .* cos(theta));

% to get cartesian position, simply put L for the angle (true longitude
% is true!)
cart = [radius .* cos(L); radius .* sin(L)];
end