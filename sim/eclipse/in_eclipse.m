function occluded = in_eclipse(r_spacecraft, r_sun, radius_body)
% OCCULUDED = IN_ECLIPSE(R_SPACECRAFT, R_SUN, RADIUS_BODY)
%
%   Determines if a spacecraft is in eclipse. Returns 1 if
%   the spacecraft is in eclipse, 0 otherwise.
%
%  Inputs:
%    r_spacecraft   - Position of the spacecraft [m]
%    r_sun          - Position of the sun [m]
%    radius_body    - Radius of the body [m]
%
%  Outputs:
%    occluded       - Boolean, 1 if spacecraft is in eclipse, 0 otherwise
% Derived from Curtis Orbital Mechanics 2014

mag_r_spacecraft = vecnorm(r_spacecraft, 2, 1);
mag_r_sun = vecnorm(r_sun, 2, 1);

% Angle between Sun and Spacecraft
theta = acos(dot(r_spacecraft, r_sun) ./ (mag_r_sun .* mag_r_spacecraft));

% Angle between Spacecraft and Tangency Ray to Body
theta_spacecraft = acos(radius_body ./ mag_r_spacecraft);
theta_sun = acos(radius_body ./ mag_r_sun);

occluded = (theta_spacecraft + theta_sun) <= theta;

end