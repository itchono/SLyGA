function plot_osculating_mee(p, f, g, t)
% Expect p, f, g, L to each be (1, N) vectors
% Best to use evenly space vectors in time (consider using interp_mee)
% Reference: https://www.mathworks.com/help/matlab/ref/getframe.html
L_sample = linspace(0, 2*pi);
plot_circle(0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

cart_sample = mee2cartesian(p(1), f(1), g(1), L_sample);
plot(cart_sample(1, :), cart_sample(2, :), "Color", "#EFA42C", "DisplayName", "Initial Orbit");

cart_sample = mee2cartesian(p(end), f(end), g(end), L_sample);
plot(cart_sample(1, :), cart_sample(2, :), "Color", "#1B61E4", "DisplayName", "Final Orbit");

legend("AutoUpdate", "off")

axis equal;

loops = length(p);
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    cart_sample = mee2cartesian(p(j), f(j), g(j), L_sample);
    osc_orbit = plot(cart_sample(1, :), cart_sample(2, :), "Color", "black");
    title(sprintf("t = %d (Frame %d of %d)", t(j), j, loops))
    drawnow
    F(j) = getframe(gcf);
    delete(osc_orbit)
end


end