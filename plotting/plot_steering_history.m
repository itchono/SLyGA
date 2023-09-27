function plot_steering_history(y, t, y_target)
%% Preprocessing
err = steering_loss(y, y_target);
[alpha, beta] = lyapunov_steering(t, y, y_target);

alpha_f = zeros(size(alpha));
beta_f = zeros(size(beta));

for j = 1:length(t)
    [alpha_f(j), beta_f(j)] = ndf_heuristic(t(j), y(:, j), alpha(j), beta(j));
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
legend("Alpha", "Beta")
ylabel("Adapted Steering Angles")
grid


subplot(313)
plot(t/86400, err, "LineWidth", 1)
legend("Guidance Error")
ylabel("Guidance Error")
xlabel("Time since vernal equinox (d)")
grid
end

