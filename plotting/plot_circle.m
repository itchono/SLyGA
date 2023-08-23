function circ = plot_circle(x, y, r, c)
% plot_circle(x,y,r,c) plots a filled circle
% x,y,r are the center and radius of the circle
% c is the color of the circle
% circ is the handle of the circle

hold on
th = 0:pi / 50:2 * pi;
x_circle = r * cos(th) + x;
y_circle = r * sin(th) + y;
circ = plot(x_circle, y_circle);
fill(x_circle, y_circle, c, "EdgeColor", "none")
hold off

end
