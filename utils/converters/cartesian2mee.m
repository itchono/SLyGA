function m = cartesian2mee(pos, vel)

mu = 3.986e14;

% https://github.com/jacobwilliams/Fortran-Astrodynamics-Toolkit/blob/master/src/modified_equinoctial_module.f90
% transcribed by chatgpt
rdv = dot(pos, vel);
rhat = pos / norm(pos);
rmag = norm(pos);
hvec = cross(pos, vel);
hmag = norm(hvec);
hhat = hvec / hmag;
vhat = (rmag * vel - rdv * rhat) / hmag;
p = hmag^2 / mu;
k = hhat(1) / (1 + hhat(3));
h = -hhat(2) / (1 + hhat(3));
kk = k^2;
hh = h^2;
s2 = 1 + hh + kk;
tkh = 2 * k * h;
ecc = cross(vel, hvec) / mu - rhat;
fhat = [1 - kk + hh; tkh; -2 * k];
ghat = [tkh; 1 + kk - hh; 2 * h];
fhat = fhat / s2;
ghat = ghat / s2;
f = dot(ecc, fhat);
g = dot(ecc, ghat);
L = atan2(rhat(2) - vhat(1), rhat(1) + vhat(2));

m = [p; f; g; h; k; L];
end