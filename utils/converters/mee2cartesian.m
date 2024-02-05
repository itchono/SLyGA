function cart = mee2cartesian(m)
% MEE2CARTESIAN converts modified equinoctial elements to cartesian
% coordinates. The inputs should be vectors or scalars, but all should be
% the same size. The outputs will be the same size as the inputs.
%
%   Inputs:
%       m - modified eqinoctial elements (m, rad)
%   Outputs:
%       cart - position/velocity in cartesian coordinates (m, m/s)

% formulation from
% https://spsweb.fltops.jpl.nasa.gov/portaldataops/mpg/MPG_Docs/Source%20Docs/EquinoctalElements-modified.pdf

% unpack elements
[p, f, g, h, k, L] = unpack_mee(m);

% Work with alpha and s squared instead of alpha and s (sqrt'ed), because
% sometimes these values can be less than zero, causing issues (we want to
% keep things strictly real)
alpha_sq = h.^2 - k.^2;
s_sq = 1 + h.^2 + k.^2;
q = 1 + f .* cos(L) + g .* sin(L);
r = p ./ q;

pos = r ./ (s_sq) .* [cos(L) + alpha_sq .* cos(L) + 2 * h .* k .* sin(L); ...
    sin(L) - alpha_sq .* sin(L) + 2 * h .* k .* cos(L); ...
    2 .* (h .* sin(L) - k .* cos(L))];
mu = 3.986e14;

vel = 1 ./ s_sq .* sqrt(mu./p) .* [-(sin(L) + alpha_sq .* sin(L) - 2 .* h .* k .* cos(L) + g - 2 .* f .* h .* k + alpha_sq .* g); ...
    -(-cos(L) + alpha_sq .* cos(L) + 2 .* h .* k .* sin(L) - f + 2 .* g .* h .* k + alpha_sq .* f); ...
    2 .* (h .* cos(L) + k .* sin(L) + f .* h + g .* k)];

cart = [pos; vel];

end