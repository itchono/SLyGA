function print_cfg_summary(cfg)
% PRINT_CFG_SUMMARY
%
%   PRINT_CFG_SUMMARY(cfg)
%   print out details about a mission configuration, writing to file as
%   well

FIDS = [1, fopen(fullfile("outputs", cfg.casename, 'cfg_summary.txt'), 'w')];

for i = 1:2
    fid = FIDS(i);
    fprintf(fid, "Initial state:\n\tp: %g\n\tf: %g\n\tg: %g\n\th: %g\n\tk: %g\n\tL: %g\n", cfg.y0(1), cfg.y0(2), cfg.y0(3), cfg.y0(4), cfg.y0(5), cfg.y0(6));
    fprintf(fid, "Target orbit:\n\tp: %g\n\tf: %g\n\tg: %g\n\th: %g\n\tk: %g\n", cfg.y_target(1), cfg.y_target(2), cfg.y_target(3), cfg.y_target(4), cfg.y_target(5));
    fprintf(fid, "Propulsion model: %s\n", func2str(cfg.propulsion_model));
    fprintf(fid, "Steering law: %s\n", func2str(cfg.steering_law));
    fprintf(fid, "ODE Solver: %s\n", func2str(cfg.solver));

end

fclose(FIDS(2));
end