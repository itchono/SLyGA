function plot_quivers(t, y, y_target)
% plot sail normal, sun direciton, etc

[~, sun_dir_i] = sun_position(t);
CIO = rot_inertial_LVLH(y);
COI = CIO';

sun_dir_o = COI * sun_dir_i;

% GNC
[alpha, beta] = q_law(t, y, y_target);

n_lyapunov_o = steering2lvlh(alpha, beta);

% Adjust targeted steering angle if needed
[alpha, beta] = cone_adaptation(t, y, alpha, beta);

n_ndf_o = steering2lvlh(alpha, beta);

quiver3(0, 0, 0, -sun_dir_o(1), -sun_dir_o(2), -sun_dir_o(3))
hold on
quiver3(0, 0, 0, n_lyapunov_o(1), n_lyapunov_o(2), n_lyapunov_o(3))
quiver3(0, 0, 0, n_ndf_o(1), n_ndf_o(2), n_ndf_o(3))
legend("Incident Light", "Q-Law", "NDF Adaptation")

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis square
end