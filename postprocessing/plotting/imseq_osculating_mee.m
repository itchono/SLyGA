function imseq_osculating_mee(y, save_path, view_dim)
% Expect y to be (6, N)
% no need to interpolate vectors unless you have VERY big skips in L
% Reference: https://www.mathworks.com/help/matlab/ref/getframe.html
% Splits by orbit number

[~, ~, ~, ~, ~, L] = unpack_mee(y);

if nargin < 3
    view_dim = 3;
end

%% Data processing
ind_orbits = find(diff(mod(L, 2*pi)) < 0);
num_orbits = length(ind_orbits);

%% Initial plot stuff
L_sample = linspace(0, 2*pi, 100);
plot_sphere(0, 0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

cm = colormap("winter");

% plot initial trace
cart_sample = mee2cartesian([repmat(y(1:5, 1), 1, numel(L_sample)); L_sample]);
plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(1, :), "DisplayName", "Initial Orbit", "LineWidth", 1, "LineStyle", "--");

% plot main orbit
main_orbit = plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", "black", "DisplayName", "Current Orbit", "LineWidth", 1);

% plot final trace
cart_sample = mee2cartesian([repmat(y(1:5, end), 1, numel(L_sample)); L_sample]);
plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(end, :), "DisplayName", "Final Orbit", "LineWidth", 1, "LineStyle", "--");

axis equal
axis off
view(view_dim)

%% Initialize path
workingDir = save_path;
mkdir(workingDir)
mkdir(workingDir,"images")

%% Animation
% spacing; never plot more than 20 frames
stride = max(1, ceil(num_orbits/20));

% ensure we always plot the last orbit
ii = 1; % counter
for j = [1:stride:num_orbits, num_orbits]
    % Update plots
    idx = ind_orbits(j);
    cart_sample = mee2cartesian([repmat(y(1:5, idx), 1, numel(L_sample)); L_sample]);
    main_orbit.XData = cart_sample(1, :);
    main_orbit.YData = cart_sample(2, :);
    main_orbit.ZData = cart_sample(3, :);
    
    % Add shadow of previous orbits
    colour_idx = ceil(j/num_orbits*length(cm));
    plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(colour_idx, :), "LineWidth", 0.5);
   
    
    % Draw and get frame
    drawnow
    saveas(gcf, fullfile(workingDir,"images",sprintf("anim-%d.png", ii)))
    ii = ii + 1; % JANK but works
end
end