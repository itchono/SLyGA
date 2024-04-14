function [alpha, beta] = cone_adaptation(t, y, alpha_star, beta_star, cfg)
% CONE_ADAPTATION  generate new steering angles if the original target
% angles are not possible with a solar sail
%  [alpha, beta] = cone_adaptation(t, y, alpha_star, beta_star)
%
% Inputs:
%  t - current time
%  y - state at current time
%  alpha_star, beta_star - original steering angles
%  cfg - configuration which included feathering and degradation angles
%
% Outputs:
%  alpha, beta - new steering angles

% Threshold angle
kappa_d = cfg.kappa_d; % degraded guidance threshold
kappa_f = cfg.kappa_f; % feathering threshold

% Calculate resultant cone angle from attitude
CIO = rot_inertial_LVLH(y);
COI = CIO';
n_star_i = CIO * steering2lvlh(alpha_star, beta_star);
[~, u_sun] = sun_position(t);
u_i = -u_sun;
c_cone_ang = dot(n_star_i, u_i);

% re-orient sail if needed
if c_cone_ang < cos(kappa_f)
    % Feather the sail if we're below kappa_f
    b_i = cross(u_i, cross(n_star_i, u_i));
    [alpha, beta] = lvlh2steering(COI*b_i);
    
    % EXPERIMENT: apply a smoothing to "interpolate" between kappa_d and f
    % b_i = cross(u_i, cross(n_star_i, u_i));
    % n_prime_i = cos(kappa_d) * u_i + sin(kappa_d) * b_i;
    % [alpha, beta] = lvlh2steering(COI*n_prime_i);
    
elseif c_cone_ang < cos(kappa_d)
    % Degraded guidance, if we're between kappa_d and kappa_f
    % vector in plane of u_i and n_star, but orthogonal to u_i
    b_i = cross(u_i, cross(n_star_i, u_i));
    n_prime_i = cos(kappa_d) * u_i + sin(kappa_d) * b_i;
    [alpha, beta] = lvlh2steering(COI*n_prime_i);
else
    alpha = alpha_star;
    beta = beta_star;
end
