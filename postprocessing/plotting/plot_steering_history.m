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
    [alpha_f(j), beta_f(j)] = ndf_heuristic(t(j), y(:, j), alpha(j), beta(j), cfg);
end

%% Rates
rate_alpha_f = diff(alpha_f) ./ diff(t);
rate_beta_f = diff(beta_f) ./ diff(t);
rate_alpha_r = diff(alpha) ./ diff(t);
rate_beta_r = diff(beta) ./ diff(t);

%% Plot
subplot(221)
plot(t/86400, rad2deg(alpha), "LineWidth", 1)
hold on
plot(t/86400, rad2deg(beta), "LineWidth", 1)
legend("alpha", "beta")
ylabel("Q-Law Raw Steering Angles")
grid


subplot(222)
plot(t/86400, rad2deg(alpha_f), "LineWidth", 1)
hold on
plot(t/86400, rad2deg(beta_f), "LineWidth", 1)
legend("Alpha", "Beta")
ylabel("Adapted (Actual) Steering Angles")
grid


subplot(223)
plot(t/86400, err, "LineWidth", 1)
ylabel("Guidance Error")
xlabel("Time since vernal equinox (d)")
grid

subplot(224)
semilogy(t(1:end-1)/86400, rad2deg(abs(rate_alpha_f)), "LineWidth", 1)
hold on
semilogy(t(1:end-1)/86400, rad2deg(abs(rate_beta_f)), "LineWidth", 1)
yline(10/3600, "--")
semilogy(t(1:end-1)/86400, rad2deg(abs(rate_alpha_r)), "--")
semilogy(t(1:end-1)/86400, rad2deg(abs(rate_beta_r)), "--")
ylabel("Abs. Steering Rates (rad/s)")
xlabel("Time since vernal equinox (d)")
legend("Alpha", "Beta", "10 deg/hr")
grid

end
