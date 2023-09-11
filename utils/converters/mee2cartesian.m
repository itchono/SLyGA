function [pos, vel] = mee2cartesian(p, f, g, h, k, L)
% MEE2CARTESIAN converts modified equinoctial elements to cartesian
% coordinates. The inputs should be vectors or scalars, but all should be
% the same size. The outputs will be the same size as the inputs.
%
%   Inputs:
%       p - semilatus rectum (m)
%       f - component of eccentricity vector (1)
%       g - component of eccentricity vector (1)
%       h - parameter 1 related to RAAN and inclination (1)
%       k - parameter 2 related to RAAN and inclination (1)
%       L - true longitude (rad)
%
%   Outputs:
%       pos - position in cartesian coordinates (m)
%       vel - velocity in cartesian coordinates (m)

% formulation from
% https://spsweb.fltops.jpl.nasa.gov/portaldataops/mpg/MPG_Docs/Source%20Docs/EquinoctalElements-modified.pdf
alpha = sqrt(h.^2-k.^2);
s = sqrt(1+h.^2+k.^2);
q = 1 + f .* cos(L) + g .* sin(L);
r = p ./ q;

pos = r ./ (s.^2) .* [cos(L) + alpha.^2 .* cos(L) + 2 * h .* k .* sin(L); ...
    sin(L) - alpha.^2 .* sin(L) + 2 * h .* k .* cos(L); ...
    2 * (h .* sin(L) - k .* cos(L))];
mu = 3.986e14;

vel = 1 / s.^2 .* sqrt(mu./p) .* [-(sin(L) + alpha.^2 .* sin(L) - 2 * h .* k .* cos(L) + g - 2 .* f .* h .* k + alpha.^2 .* g); ...
    -(-cos(L) + alpha.^2 .* cos(L) + 2 * h .* k .* sin(L) - g + 2 .* g .* h .* k + alpha.^2 .* f); ...
    2 * (h .* cos(L) + k .* sin(L) + f .* h + g .* k)];

end