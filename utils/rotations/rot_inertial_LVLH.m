function CIO = rot_inertial_LVLH(m)
% ROT_INERTIAL_LVLH Rotation from LVLH to inertial frame
%
% Syntax:  CIO = rot_inertial_LVLH(m)
%
% Inputs:
%    m - state in modified equinoctial elements
%
% Outputs:
%    CIO - 3x3 rotation matrix from LVLH to inertial frame s.t. v_I = CIO*v_LVLH
%

cart = mee2cartesian(m);
pos = cart(1:3); % position vector
vel = cart(4:6); % velocity vector
% vectors expressed in inertial frame

pos_u = pos / norm(pos);
vel_u = vel / norm(vel);

% MAKE SURE TO NORMALIZE h, because r x v is not always unit magnitude
h = cross(pos_u, vel_u) / norm(cross(pos_u, vel_u));

CIO = [pos_u, cross(h, pos_u), h];
end