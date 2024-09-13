% plot for vector export, maximum # of lines etc.

function plot_orbit_vecex(y)
% Expect y to be (6, N)
% Splits by orbit number so that maximum number of lines is under 300

[~, ~, ~, ~, ~, L] = unpack_mee(y);

%% Data processing
ind_orbits = find(diff(mod(L, 2*pi)) < 0);
num_orbits = length(ind_orbits);

%% Initial plot stuff
L_sample = linspace(0, 2*pi, 60);
plot_sphere(0, 0, 0, 6378e3, [0.3010, 0.7450, 0.9330]);
hold on

cm = colormap("turbo");

NMAX = 200;

% spacing
stride = max(1, ceil(num_orbits/NMAX));

% ensure we always plot the last orbit
for j = [1:stride:num_orbits, num_orbits]
    % Update plots
    idx = ind_orbits(j);
    cart_sample = mee2cartesian([repmat(y(1:5, idx), 1, numel(L_sample)); L_sample]);
    
    % Add shadow of previous orbits
    colour_idx = ceil(j/num_orbits*length(cm));
    plot3(cart_sample(1, :), cart_sample(2, :), cart_sample(3, :), "Color", cm(colour_idx, :), "LineWidth", 0.5);
end

title(sprintf("Earth Inertial Coordinates (Showing Every %d Orbits)", stride));
xlabel("x (m)")
ylabel("y (m)")
zlabel("z (m)")
cbar = colorbar;

% wrangle the discrete colorbar tick alignment
cbscalein = cbar.Limits;
cbscaleout = [0 num_orbits];
nt = 8;
ticks = linspace(cbscaleout(1),cbscaleout(2), nt);
cbar.Ticks = diff(cbscalein)*(ticks-cbscaleout(1))/diff(cbscaleout) + cbscalein(1);
cbar.TickLabels = round(linspace(0, num_orbits, nt)');

ylabel(cbar, "Orbit Number")
axis equal;
view(3)
end