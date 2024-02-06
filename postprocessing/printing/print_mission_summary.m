function print_mission_summary(y, t, dv, cfg, time_elapsed)
%  PRINT_MISSION_SUMMARY  prints a summary of post-mission details, writing
%  to file as well

[~, ~, ~, ~, ~, L] = unpack_mee(y);

ind_orbits = find(diff(mod(L, 2*pi)) < 0);
num_orbits = length(ind_orbits);

final_err = steering_loss(y(:, end), cfg.y_target, cfg.guidance_weights);

FIDS = [1, fopen(fullfile("outputs", cfg.casename, 'mission_summary.txt'), 'w')];

for i = 1:2
    fid = FIDS(i);
    fprintf(fid, "FINISHED in %.2f seconds (compute)\n", time_elapsed);

    if final_err < cfg.tol
        fprintf(fid, "   _____ ____  _   ___      ________ _____   _____ ______ _____  _ \n  / ____/ __ \\| \\ | \\ \\    / /  ____|  __ \\ / ____|  ____|  __ \\| |\n | |   | |  | |  \\| |\\ \\  / /| |__  | |__) | |  __| |__  | |  | | |\n | |   | |  | | . ` | \\ \\/ / |  __| |  _  /| | |_ |  __| | |  | | |\n | |___| |__| | |\\  |  \\  /  | |____| | \\ \\| |__| | |____| |__| |_|\n  \\_____\\____/|_| \\_|   \\/   |______|_|  \\_\\\\_____|______|_____/(_)\n");
    else
        fprintf(fid, "NOT CONVERGED!!\n");
    end
    fprintf(fid, "Achieved error of %g (vs tolerance %g) after %d orbits (%.f seconds) with %d solver steps\n", ...
        final_err, cfg.tol, num_orbits, t(end), length(t));
    
    fprintf(fid, "Total DV expenditure: %.1f m/s\n", dv(end));
end

fclose(FIDS(2));
end