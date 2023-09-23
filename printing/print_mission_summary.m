function print_mission_summary(y, t, dv, mission_cfg)
%  PRINT_MISSION_SUMMARY  prints a summary of post-mission details

[p, f, g, h, k, L] = unpack_mee(y);

num_orbits = round(L(end)/(2 * pi));
final_err = steering_loss([p(end); f(end); g(end); h(end); k(end); L(end)], mission_cfg.y_target);
fprintf("Propagation terminated after %d orbits (%.f seconds) with %d solver steps\n", num_orbits, t(end), length(t));
if final_err < mission_cfg.tol
    fprintf("CONVERGED: ")
else
    fprintf("NOT CONVERGED: ")
end
fprintf(" achieved error of %g (vs tolerance %g)\n", final_err, mission_cfg.tol);
fprintf("Total DV expenditure: %.1f m/s\n", dv(end));
end