function print_mission_summary(y, t, dv, mission_cfg)
%  PRINT_MISSION_SUMMARY  prints a summary of post-mission details

[p, f, g, h, k, L] = unpack_mee(y);

num_orbits = round(L(end)/(2 * pi));
final_err = steering_loss([p(end); f(end); g(end); h(end); k(end); L(end)], mission_cfg.y_target);
if final_err < mission_cfg.tol
    fprintf("   _____ ____  _   ___      ________ _____   _____ ______ _____  _ \n  / ____/ __ \\| \\ | \\ \\    / /  ____|  __ \\ / ____|  ____|  __ \\| |\n | |   | |  | |  \\| |\\ \\  / /| |__  | |__) | |  __| |__  | |  | | |\n | |   | |  | | . ` | \\ \\/ / |  __| |  _  /| | |_ |  __| | |  | | |\n | |___| |__| | |\\  |  \\  /  | |____| | \\ \\| |__| | |____| |__| |_|\n  \\_____\\____/|_| \\_|   \\/   |______|_|  \\_\\\\_____|______|_____/(_)\n")
else
    fprintf("NOT CONVERGED!!\n")
end
fprintf("Achieved error of %g (vs tolerance %g) after %d orbits (%.f seconds) with %d solver steps\n",...
    final_err, mission_cfg.tol, num_orbits, t(end), length(t));

fprintf("Total DV expenditure: %.1f m/s\n", dv(end));
end