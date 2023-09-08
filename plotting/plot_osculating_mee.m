function plot_osculating_mee(p, f, g, t)
% Expect p, f, g, L to each be (1, N) vectors
% Best to use evenly space vectors in time (consider using interp_mee)
% Reference: https://www.mathworks.com/help/matlab/ref/getframe.html

%% Initial plot stuff
h = gcf;

L_sample = linspace(0, 2*pi, 200);
plot_circle(0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on
cart_sample = mee2cartesian(p(1), f(1), g(1), L_sample);
plot(cart_sample(1, :), cart_sample(2, :), "Color", "#EFA42C", "DisplayName", "Initial Orbit", "LineWidth", 2, "LineStyle", ":");

main_orbit = plot(cart_sample(1, :), cart_sample(2, :), "Color", "black", "DisplayName", "Current Orbit", "LineWidth", 2);

cart_sample = mee2cartesian(p(end), f(end), g(end), L_sample);
plot(cart_sample(1, :), cart_sample(2, :), "Color", "#27CC53", "DisplayName", "Final Orbit", "LineWidth", 2, "LineStyle", ":");
axis equal

%% Initialize video
myVideo = VideoWriter('slyga_video', 'MPEG-4'); %open video file
myVideo.FrameRate = 30;
open(myVideo)

%% Animation
loops = length(p);
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    cart_sample = mee2cartesian(p(j), f(j), g(j), L_sample);
    main_orbit.XData = cart_sample(1, :);
    main_orbit.YData = cart_sample(2, :);
    title(sprintf("t = %d (Frame %d of %d)", t(j), j, loops));
    drawnow
    F(j) = getframe(h);
    writeVideo(myVideo, F(j));
end


close(myVideo)
end