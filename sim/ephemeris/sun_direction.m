function dir = sun_direction(t)
% Returns a 3D unit vector of sun direction
phi = sun_angle(t);
dir = [cos(phi); sin(phi); 0];

end