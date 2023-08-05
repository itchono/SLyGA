%% Config
y0 = [6878e3; 0; 0; 0];
propagator = @ode45;
t_span = [0, 86400];

%% Run
[t, y] = propagator(@gnc_stack, t_span, y0);

p = y(:, 1);

figure
plot(t, p);


%% Plot
figure
plot_orbit_moe_vec(t, y, 120);