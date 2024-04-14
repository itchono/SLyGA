function yp = dyn_mee(t, y, cfg)
% DYN_MEE top-level dynamics in modified equinoctial elements
%   YP = DYN_MEE(T, Y, CFG) returns
%   the time derivative in modified equinoctial elements for the state
%   vector Y at time T.

%   State is 7x1, 6 for orbital elements and 1 for dv

% Scaling, for error tolerance only (guidance law does scaling internally,
% so we feed it in the unscaled values)
y = [y(1) * 6378e3; y(2:end)];

% GNC
[alpha, beta] = cfg.steering_law(t, y, cfg);

% Propulsion
acceleration = cfg.propulsion_model(t, y, alpha, beta);
if cfg.j2
    acceleration = acceleration + J2_perturbation(y);
end

% Dynamics
yp = [gve_mee(y, acceleration); norm(acceleration)];
yp(1) = yp(1) / 6378e3;

end