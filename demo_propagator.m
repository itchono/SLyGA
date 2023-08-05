%% Config
y0 = [6878e3; 0; 0; 0];
propagator = @ode113;
t_span = [0, 4e5];
opts = odeset('RelTol',1e-12);

%% Run
[t, y] = propagator(@gnc_stack, t_span, y0, opts);
[p, f, g, L] = unpack_meo(y');

% get proxy quantities
ecc = sqrt(f.^2 + g.^2);
sma = p .* (1-ecc.^2);

%% Plot
figure
labels = ["Semi-Major Axis (m)", "f (x-eccentricity)", "g (y-eccentricity)"];
stackedplot(t/86400, [sma; f; g]', "DisplayLabels", labels);

title("Evolution of Orbital Elements for pi/6 Steering Law");
xlabel("Time since vernal equinox (d)")

figure
plot_orbit_meo_vec(t, y, 120);