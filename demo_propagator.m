y0 = [6878e3; 0.2; 0.1; 0];

[t, y] = ode113(@eom_gve_moe, [0, 5700], y0);

plot_orbit_moe_vec(y);