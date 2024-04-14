function yp = dyn_cartesian(t, y, cfg)
% DYN_CART top-level dynamics in Cartesian coordinates
%   YP = DYN_CART(T, Y, CFG) returns
%   the time derivative in Cartesian coordinates for the state
%   vector Y at time T.

%   State is 7x1, 6 for orbital elements and 1 for dv

% No scaling is needed for cartesian, but we must convert to modified
% equinoctial elements
y_mee = cartesian2mee(y);

% GNC
[alpha, beta] = cfg.steering_law(t, y_mee, cfg);

% Propulsion
acceleration = cfg.propulsion_model(t, y, alpha, beta);
if cfg.j2
    acceleration = acceleration + J2_perturbation(y);
end

% Dynamics
yp = [n2_cartesian(y, acceleration); norm(acceleration)];

end