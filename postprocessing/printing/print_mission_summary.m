function print_mission_summary(y, t, dv, mission_cfg)
%  PRINT_MISSION_SUMMARY  prints a summary of post-mission details, writing
%  to file as well

[p, f, g, h, k, L] = unpack_mee(y);

num_orbits = round(L(end)/(2 * pi));
final_err = steering_loss([p(end); f(end); g(end); h(end); k(end); L(end)], mission_cfg.y_target, mission_cfg.guidance_weights);

FIDS = [1, fopen(fullfile("outputs", mission_cfg.casename, 'mission_summary.txt'), 'w')];

for i = 1:2
    fid = FIDS(i);
    if final_err < mission_cfg.tol
        fprintf(fid, "   _____ ____  _   ___      ________ _____   _____ ______ _____  _ \n  / ____/ __ \\| \\ | \\ \\    / /  ____|  __ \\ / ____|  ____|  __ \\| |\n | |   | |  | |  \\| |\\ \\  / /| |__  | |__) | |  __| |__  | |  | | |\n | |   | |  | | . ` | \\ \\/ / |  __| |  _  /| | |_ |  __| | |  | | |\n | |___| |__| | |\\  |  \\  /  | |____| | \\ \\| |__| | |____| |__| |_|\n  \\_____\\____/|_| \\_|   \\/   |______|_|  \\_\\\\_____|______|_____/(_)\n");
    else
        fprintf(fid, "NOT CONVERGED!!\n");
    end
    fprintf(fid, "Achieved error of %g (vs tolerance %g) after %d orbits (%.f seconds) with %d solver steps\n", ...
        final_err, mission_cfg.tol, num_orbits, t(end), length(t));

    fprintf(fid, "Total DV expenditure: %.1f m/s\n", dv(end));
end

fclose(FIDS(2));
end