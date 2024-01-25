function circ = plot_sphere(x, y, z, r, c)
% plot_circle(x,y,z,r,c) plots a filled sphere
% x,y,z,r are the center and radius of the sphere
% c is the color of the sphere
% circ is the handle of the sphere

[X, Y, Z] = sphere;

circ = surf(X*r-x, Y*r-y, Z*r, 0, ...
    "FaceColor", c, "EdgeColor", "none", "HandleVisibility", "off");

end
