function acc_lvlh = sail_thrust(t, y, gamma)
[p, f, g, L] = unpack_meo(y);
theta = L - atan2(g, f);

% parameters
P = 9.12e-6;  % N/m^2
sigma = 0.001; % kg/m^2
eta = 0.85;

% thrust
efficiency_coeff = 2*P*eta/sigma;
angular_coeff = sin(gamma - theta + sun_angle(t)).^2;
sign_multiplier = sign(cos(gamma - theta + sun_angle(t)));  % VERY IMPORTANT, FIGURE OUT HOW TO GENERALIZE!

acc_lvlh = efficiency_coeff .* sign_multiplier .* angular_coeff .* [sin(gamma); cos(gamma)];

end
