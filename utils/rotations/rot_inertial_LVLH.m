function COI = rot_inertial_LVLH(p, f, g, h, k, L)
% Rotation matrix from LVLH to inertial (active rotation)
[pos, vel] = mee2cartesian(p, f, g, h, k, L);
% vectors expressed in inertial frame

pos_u = pos / norm(pos);
vel_u = vel / norm(vel);

% MAKE SURE TO NORMALIZE h, because r x v is not always unit magnitude
h = cross(pos_u, vel_u) / norm(cross(pos_u, vel_u));

COI = [pos_u, cross(h, pos_u), h];
end