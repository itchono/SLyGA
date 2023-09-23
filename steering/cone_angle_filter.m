function [alpha, beta] = cone_angle_filter(t, y, alpha_star, beta_star)
% CONE_ANGLE_FILTER  Filter cone angle to put sail at 0 cone angle
% if the desired steering angle would face towards the sun.

% Threshold angle
kappa_t = deg2rad(90);
kappa_n = deg2rad(90);

[p, f, g, h, k, L] = unpack_mee(y);

% Calculate resultant cone angle from attitude
CIO = rot_inertial_LVLH(p, f, g, h, k, L);
COI = CIO';
n_star_i = CIO *  steering2lvlh(alpha_star, beta_star);
u_i = -sun_direction(t);
c_cone_ang = dot(n_star_i, u_i);

% re-orient sail if needed
if c_cone_ang < cos(kappa_n)
    % Zero thrust, if we're pointing definitely the wrong way
    b_i = cross(u_i, cross(n_star_i, u_i));
    [alpha, beta] = lvlh2steering(COI * b_i);
elseif c_cone_ang < cos(kappa_t)
    % Degraded thrust, if we're between kappa_t and kappa_n
    % vector in plane of u_i and n_star, but orthogonal to u_i
    b_i = cross(u_i, cross(n_star_i, u_i));
    n_prime_i = cos(kappa_t) * u_i + sin(kappa_t) * b_i;
    [alpha, beta] = lvlh2steering(COI * n_prime_i);
else
    alpha = alpha_star;
    beta = beta_star;
end
