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
kappa = cfg.kappa; % degraded guidance threshold

% Calculate resultant cone angle from attitude
CIO = rot_inertial_LVLH(y);
COI = CIO';
n_star_i = CIO * steering2lvlh(alpha_star, beta_star);
[~, u_sun] = sun_position(t);
u_i = -u_sun;
c_cone_ang = dot(n_star_i, u_i);

% re-orient sail if needed
if c_cone_ang < 0
    % Feather the sail if we're below limit plane
    b_i = cross(u_i, cross(n_star_i, u_i));
    [alpha, beta] = lvlh2steering(COI*b_i);
    
elseif c_cone_ang < cos(kappa)
    % Projected guidance
    % vector in plane of u_i and n_star, but orthogonal to u_i
    b_i = cross(u_i, cross(n_star_i, u_i));
    n_prime_i = cos(kappa) * u_i + sin(kappa) * b_i;
    [alpha, beta] = lvlh2steering(COI*n_prime_i);
else
    % Use solution as-is
    alpha = alpha_star;
    beta = beta_star;
end
