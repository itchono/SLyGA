function [alpha, beta] = quail(t, y, cfg)
% QUAIL  Combined steering law
% [alpha, beta] = quail(t, y, cfg) calculates the steering angles for the
% current state and time using a combined Q-Law with cone angle adaptation
%
% Inputs:
%   t = current time
%   y = current state
%   y_tgt = target state
%
% Outputs:
%   [alpha, beta] = steering angles

% First Stage
[alpha_s, beta_s] = q_law(t, y, cfg);

% Second Stage
[alpha, beta] = cone_adaptation(t, y, alpha_s, beta_s, cfg);

end