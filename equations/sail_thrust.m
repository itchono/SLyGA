function acc_lvlh = sail_thrust(t, y, gamma)
[p, f, g, L] = unpack_meo(y);

% parameters
P = 9.12e-6;  % N/m^2
sigma = 0.001; % kg/m^2
eta = 0.85;

% sail orientation
alpha = L - pi/2 - gamma - sun_angle(t);

% thrust
efficiency = 2*P*eta/sigma;
direction = [sin(gamma); cos(gamma)];
acc_lvlh = efficiency .* sign(cos(alpha)) .* cos(alpha).^2 .* direction;

end
