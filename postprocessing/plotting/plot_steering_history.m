function plot_steering_history(y, t, cfg)

%% Preprocessing
err = steering_loss(y, cfg.y_target, cfg.guidance_weights);

alpha = zeros(length(t), 1);
beta = zeros(length(t), 1);

alpha_f = zeros(length(t), 1);
beta_f = zeros(length(t), 1);

cone_mode = zeros(length(t), 1);

for j = 1:length(t)
    % yup this is slow, but that's the price to pay for getting rid of
    % explicit-ness in lyapunov steering
    [alpha(j), beta(j)] = q_law(t(j), y(:, j), cfg);
    [alpha_f(j), beta_f(j)] = cone_adaptation(t(j), y(:, j), alpha(j), beta(j), cfg);
    cone_mode(j) = cone_adaptation_mode(t(j), y(:, j), alpha(j), beta(j), cfg);
end

%% Rates
rate_alpha_f = diff(alpha_f) ./ diff(t);
rate_beta_f = diff(beta_f) ./ diff(t);
rate_alpha_r = diff(alpha) ./ diff(t);
rate_beta_r = diff(beta) ./ diff(t);

%% Filter
td = 0;
tm = 10;
alpha = alpha(t/86400>td & t/86400<tm);
beta = beta(t/86400>td & t/86400<tm);
alpha_f = alpha_f(t/86400>td & t/86400<tm);
beta_f = beta_f(t/86400>td & t/86400<tm);
t = t(t/86400>td & t/86400<tm);
cone_mode = cone_mode(t/86400>td & t/86400<tm);

%% Plot
fh = gcf();
fh.Position(3:4) = [560, 600];
fh.Position(2) = 50;

subplot(311)
plot(t/86400, rad2deg(alpha), "k", "LineWidth", 1)
hold on
plot(t/86400, rad2deg(alpha_f), "r", "LineWidth", 1)
ylabel("\alpha [deg]")
legend("Q-law Only", "With Cone Adaptation", "Location", "Best")
grid

subplot(312)
plot(t/86400, rad2deg(beta), "k", "LineWidth", 1)
hold on
plot(t/86400, rad2deg(beta_f), "r", "LineWidth", 1)
legend("Q-law Only", "With Cone Adaptation", "Location", "Best")
ylabel("\beta [deg]")
xlabel("Elapsed Time (Days)")
grid

subplot(313)
plot(t/86400, cone_mode, "k", "LineWidth", 1)
yticks([-1, 0, 1])
ylim([-1, 1])
yticklabels({'Feathered (c)','Projected (b)','Unmodified (a)'})
ylabel("Attitude Mode")
xlabel("Elapsed Time (Days)")
grid

% subplot(221)
% plot(t/86400, rad2deg(alpha), "LineWidth", 1)
% hold on
% plot(t/86400, rad2deg(beta), "LineWidth", 1)
% legend("alpha", "beta")
% ylabel("Q-Law Raw Steering Angles")
% grid
% 
% 
% subplot(222)
% plot(t/86400, rad2deg(alpha_f), "LineWidth", 1)
% hold on
% plot(t/86400, rad2deg(beta_f), "LineWidth", 1)
% legend("Alpha", "Beta")
% ylabel("Adapted (Actual) Steering Angles")
% grid
% 
% 
% subplot(223)
% plot(t/86400, err, "LineWidth", 1)
% ylabel("Guidance Error")
% xlabel("Time since vernal equinox (d)")
% grid
% 
% subplot(224)
% semilogy(t(1:end-1)/86400, rad2deg(abs(rate_alpha_f)), "LineWidth", 1)
% hold on
% semilogy(t(1:end-1)/86400, rad2deg(abs(rate_beta_f)), "LineWidth", 1)
% yline(10/3600, "--")
% semilogy(t(1:end-1)/86400, rad2deg(abs(rate_alpha_r)), "--")
% semilogy(t(1:end-1)/86400, rad2deg(abs(rate_beta_r)), "--")
% ylabel("Abs. Steering Rates (rad/s)")
% xlabel("Time since vernal equinox (d)")
% legend("Alpha", "Beta", "10 deg/hr")
% grid

end
