function acc_lvlh = sail_thrust(t, y, alpha, beta)
% SAIL_THRUST  Calculates the thrust of the solar sail in the LVLH frame.
%   acc_lvlh = sail_thrust(t, y, alpha, beta) calculates the thrust
%   acceleration in the LVLH frame at time t for the state y and steering
%   angles alpha, beta.
%
%   Inputs:
%       t           Time (s)
%       y           State vector (mee)
%       alpha       Steering angle (rad)
%       beta        Steering angle (rad)
%
%   Outputs:
%       acc_lvlh    Acceleration vector (m/s^2)
%

r_spacecraft_i = mee2cartesian(y);
r_spacecraft_i = r_spacecraft_i(1:3);


% Calculate Cone Angle/Occlusion
sc_dir_lvlh = steering2lvlh(alpha, beta);
sc_dir_i = rot_inertial_LVLH(y) * sc_dir_lvlh;
[r_sun_i, u_sun_i] = sun_position(t);
sunlight_dir_i = -u_sun_i;
c_cone_ang = dot(sc_dir_i, sunlight_dir_i);

illumination = ~in_eclipse(r_spacecraft_i, r_sun_i, 6378e3);

% prefactor for sail thrust
fac = thrust_magnitude * illumination;

% Solar sail thrust equation
acc_lvlh = fac .* sign(c_cone_ang) .* c_cone_ang.^2 .* sc_dir_lvlh;

end
