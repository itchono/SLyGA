function plot_steering_history(y, t, cfg)
%% Preprocessing
err = steering_loss(y, cfg.y_target, cfg.guidance_weights);

alpha = zeros(length(t), 1);
beta = zeros(length(t), 1);

alpha_f = zeros(length(t), 1);
beta_f = zeros(length(t), 1);

for j = 1:length(t)
    % yup this is slow, but that's the price to pay for getting rid of
    % explicit-ness in lyapunov steering
    [alpha(j), beta(j)] = lyapunov_steering(t(j), y(:, j), cfg);
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

