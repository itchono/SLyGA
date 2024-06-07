function m = cartesian2mee(cart)
% CARTESIAN2MEE converts cartesian coordinates to modified equinoctial
% elements. The inputs should be h-stacked vectors, and all be
% the same size. The outputs will be the same size as the inputs.
% Inputs:
%   cart = [6 x n] array of cartesian coordinates
% Outputs:
%   m = [6 x n] array of modified equinoctial elements

mu = 3.986e14;
pos = cart(1:3, :);
vel = cart(4:6, :);

% https:././github.com./jacobwilliams./Fortran-Astrodynamics-Toolkit./blob./master./src./modified_equinoctial_module.f90
% transcribed by chatgpt
rdv = dot(pos, vel, 1);
rhat = pos ./ vecnorm(pos, 2, 1);
rmag = vecnorm(pos, 2, 1);
hvec = cross(pos, vel, 1);
hmag = vecnorm(hvec, 2, 1);
hhat = hvec ./ hmag;
vhat = (rmag .* vel - rdv .* rhat) ./ hmag;
p = hmag.^2 ./ mu;
k = hhat(1, :) ./ (1 + hhat(3, :));
h = -hhat(2, :) ./ (1 + hhat(3, :));
kk = k.^2;
hh = h.^2;
s2 = 1 + hh + kk;
tkh = 2 .* k .* h;
ecc = cross(vel, hvec, 1) ./ mu - rhat;
fhat = [1 - kk + hh; tkh; -2 .* k];
ghat = [tkh; 1 + kk - hh; 2 .* h];
fhat = fhat ./ s2;
ghat = ghat ./ s2;
f = dot(ecc, fhat, 1);
g = dot(ecc, ghat, 1);
L = atan2(rhat(2, :) - vhat(1, :), rhat(1, :) + vhat(2, :));

% make L monotonically increasing if it's a vector
L = make_monotonically_increasing(L);

m = [p; f; g; h; k; L];
end