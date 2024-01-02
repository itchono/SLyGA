function [a, e, i, Omega, omega, theta] = mee2keplerian(p, f, g, h, k, L)
% MEE2KEPLERIAN converts modified equinoctial elements to keplerian
% elements.The inputs should be vectors or scalars, but all should be
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
%       a - semimajor axis (m)
%       e - eccentricity (1)
%       i - inclination (deg)
%       Omega - RAAN (deg)
%       omega - AOP (deg)
%       theta - TA (deg)
% Math from
% https://spsweb.fltops.jpl.nasa.gov/portaldataops/mpg/MPG_Docs/Source%20Docs/EquinoctalElements-modified.pdf

e = sqrt(f.^2+g.^2);
a = p ./ (1 - e.^2);
i = atan2d(2.*sqrt(h.^2+k.^2), 1-h.^2-k.^2);
omega = atan2d(g.*h-f.*k, f.*h+g.*k);
Omega = atan2d(k, h);
theta = L - (Omega + omega);