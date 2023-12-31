function print_cfg_summary(cfg)
% PRINT_CFG_SUMMARY
%
%   PRINT_CFG_SUMMARY(cfg)
%   print out details about a mission configuration

fprintf("Initial state:\n\tp: %g\n\tf: %g\n\tg: %g\n\th: %g\n\tk: %g\n\tL: %g\n", cfg.y0(1), cfg.y0(2), cfg.y0(3), cfg.y0(4), cfg.y0(5), cfg.y0(6));
fprintf("Target orbit:\n\tp: %g\n\tf: %g\n\tg: %g\n\th: %g\n\tk: %g\n", cfg.y_target(1), cfg.y_target(2), cfg.y_target(3), cfg.y_target(4), cfg.y_target(5));
fprintf("Propulsion model: %s\n", func2str(cfg.propulsion_model));
fprintf("Steering law: %s\n", func2str(cfg.steering_law));
fprintf("ODE Solver: %s\n", func2str(cfg.solver));


end