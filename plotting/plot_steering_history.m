function plot_steering_history(p, f, g, h, k, L, t, y_target)
%% Preprocessing
err = steering_loss([p; f; g; h; k; zeros(1, length(p))], y_target);
y = [p; f; g; h; k; L];
[alpha, beta] = lyapunov_steering(t, y, y_target);

alpha_f = zeros(size(alpha));
beta_f = zeros(size(beta));

for j = 1:length(t)
    [alpha_f(j), beta_f(j)] = cone_angle_filter(t(j), y(:, j), alpha(j), beta(j));
end

%% Plot
subplot(311)
plot(t/86400, rad2deg(alpha), "LineWidth", 1)
hold on
plot(t/86400, rad2deg(beta), "LineWidth", 1)
legend("alpha", "beta")
ylabel("Steering Angles")
title("Guidance System Performance")
grid


subplot(312)
plot(t/86400, rad2deg(alpha_f), "LineWidth", 1)
hold on
plot(t/86400, rad2deg(beta_f), "LineWidth", 1)
legend("filt alpha", "filt beta")
ylabel("Filtered Steering Angles")
grid


subplot(313)
plot(t/86400, err, "LineWidth", 1)
legend("Guidance Error")
ylabel("Guidance Error")
xlabel("Time since vernal equinox (d)")
grid
end

