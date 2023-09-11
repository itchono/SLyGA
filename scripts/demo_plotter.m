% Orbit params
p = 12000e3;
f = 0.7;
g = 0.1;
h = 0.1;
k = 0;
L = linspace(0, 2*pi);

% Control Params
gamma = 0;
t = 0;
L_plot = 2 / 3 * pi;

plot_orbit_mee(p, f, g, h, k, L);
