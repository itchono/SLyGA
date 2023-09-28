function occluded = in_eclipse(r_spacecraft, r_sun, radius_body)
% Determines occlusion
% Derived from Curtis Orbital Mechanics 2014; Algorithm 

mag_r_spacecraft = vecnorm(r_spacecraft, 2, 1);
mag_r_sun = vecnorm(r_sun, 2, 1);

% Angle between Sun and Spacecraft
theta = acos(dot(r_spacecraft, r_sun) ./ (mag_r_sun .* mag_r_spacecraft));

% Angle between Spacecraft and Tangency Ray to Body
theta_spacecraft = acos(radius_body ./ mag_r_spacecraft);
theta_sun = acos(radius_body ./ mag_r_sun);

occluded = (theta_spacecraft + theta_sun) <= theta;

end