function gamma = simple_steering(t, y, ~)
% Just increase the energy of the orbit
[~, ~, ~, L] = unpack_meo(y);

% Orbit-raising steering angle
gamma_candidate = 0;

% Calculate resultant cone angle
phi_sun = sun_angle(t);
alpha = L - pi/2 - gamma_candidate - phi_sun;

% If cone angle would result in negative thrust, produce zero thrust
% instead
if cos(alpha) < 0
    % Point sail edge-on to produce ZERO THRUST
    gamma = L - phi_sun;
else
    gamma = gamma_candidate;
end
end