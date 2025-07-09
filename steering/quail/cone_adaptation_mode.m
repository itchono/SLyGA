function [cone_mode] = cone_adaptation_mode(t, y, alpha_star, beta_star, cfg)
% Indicate which mode we're in

% Threshold angle
kappa = cfg.kappa; % degraded guidance threshold

% Calculate resultant cone angle from attitude
CIO = rot_inertial_LVLH(y);
n_star_i = CIO * steering2lvlh(alpha_star, beta_star);
[~, u_sun] = sun_position(t);
u_i = -u_sun;
c_cone_ang = dot(n_star_i, u_i);

% re-orient sail if needed
if c_cone_ang < 0
    % Feather the sail if we're below limit plane
    cone_mode=-1;
    
elseif c_cone_ang < cos(kappa)
    cone_mode=0;
else
    cone_mode=1;
end
