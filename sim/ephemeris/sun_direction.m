function dir = sun_direction(t)
% Returns a 3D unit vector of sun direction
phi = sun_angle(t);
vec = [cos(phi); sin(phi); 0];
dir = vec / norm(vec);

end