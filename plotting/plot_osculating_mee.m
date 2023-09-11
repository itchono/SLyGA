function plot_osculating_mee(p, f, g, L)
% Expect p, f, g, L to each be (1, N) vectors
% no need to interpolate vectors unless you have VERY big skips in L
% Reference: https://www.mathworks.com/help/matlab/ref/getframe.html
% Splits by orbit number

%% Data processing
ind_orbits = find(diff(mod(L, 2*pi)) < 0);
num_orbits = length(ind_orbits);

%% Initial plot stuff
h = figure;
th = title(sprintf("Orbit 1 of %d", num_orbits));

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
F(num_orbits) = struct('cdata',[],'colormap',[]);
for j = 1:num_orbits
    % Update plots
    idx = ind_orbits(j);
    cart_sample = mee2cartesian(p(idx), f(idx), g(idx), L_sample);
    main_orbit.XData = cart_sample(1, :);
    main_orbit.YData = cart_sample(2, :);
    th.String = sprintf("Orbit %d of %d", j, num_orbits);
    
    % Draw and get frame
    drawnow
    F(j) = getframe(h);
    writeVideo(myVideo, F(j));
end

close(myVideo)
end