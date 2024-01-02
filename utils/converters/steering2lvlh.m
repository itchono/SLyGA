function lvlh = steering2lvlh(alpha, beta)
% STEERING2LVLH  Converts alpha and beta steering angles into a direction vector in LVLH
%
%   lvlh = steering2lvlh(alpha, beta)
%
%   Inputs:
%       alpha - y-x plane steeering angle (rad)
%       beta  - z-direction steering angle (rad)
%
%   Outputs:
%       lvlh - direction vector in LVLH

lvlh = [cos(beta) * sin(alpha); ...
    cos(beta) * cos(alpha); ...
    sin(beta);];
end