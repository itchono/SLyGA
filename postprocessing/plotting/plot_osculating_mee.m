function plot_osculating_mee(y, save_path)
% Expect y to be (6, N)
% no need to interpolate vectors unless you have VERY big skips in L
% Reference: https://www.mathworks.com/help/matlab/ref/getframe.html
% Splits by orbit number

[p, f, g, h, k, L] = unpack_mee(y);

%% Data processing
ind_orbits = find(diff(mod(L, 2*pi)) < 0);
num_orbits = length(ind_orbits);

%% Initial plot stuff
fh = figure;

L_sample = linspace(0, 2*pi, 100);
plot_sphere(0, 0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

cm = colormap("turbo");
th = title(sprintf("Orbit 1 of %d", num_orbits));

% plot initial trace
cart_sample = mee2cartesian(p(1), f(1), g(1), h(1), k(1), L_sample);
plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(1, :), "DisplayName", "Initial Orbit", "LineWidth", 1, "LineStyle", "--");

% plot main orbit
main_orbit = plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", "black", "DisplayName", "Current Orbit", "LineWidth", 1);

% plot final trace
cart_sample = mee2cartesian(p(end), f(end), g(end), h(end), k(end), L_sample);
plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(end, :), "DisplayName", "Final Orbit", "LineWidth", 1, "LineStyle", "--");

axis equal
view(3)

%% Initialize video
myVideo = VideoWriter(save_path, 'MPEG-4'); %open video file
myVideo.FrameRate = 30;
open(myVideo)

%% Animation
F(num_orbits) = struct('cdata', [], 'colormap', []);
for j = [1:3:num_orbits, num_orbits]
    % Update plots
    idx = ind_orbits(j);
    cart_sample = mee2cartesian(p(idx), f(idx), g(idx), h(idx), k(idx), L_sample);
    main_orbit.XData = cart_sample(1, :);
    main_orbit.YData = cart_sample(2, :);
    main_orbit.ZData = cart_sample(3, :);

    % Add shadow of previous orbits
    colour_idx = ceil(j/num_orbits*length(cm));
    plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(colour_idx, :), "DisplayName", "Current Orbit", "LineWidth", 0.5);

    th.String = sprintf("Orbit %d of %d", j, num_orbits);

    % Draw and get frame
    drawnow
    F(j) = getframe(fh);
    writeVideo(myVideo, F(j));
end

close(myVideo)
end