function print_cfg_summary(cfg)
% PRINT_CFG_SUMMARY
%
%   PRINT_CFG_SUMMARY(cfg)
%   print out details about a mission configuration

fprintf("Initial state:\n\tp: %f\n\tf: %f\n\tg: %f\n\tL: %f\n", cfg.y0(1), cfg.y0(2), cfg.y0(3), cfg.y0(4));
fprintf("Target orbit:\n\tp: %f\n\tf: %f\n\tg: %f\n", cfg.y_target(1), cfg.y_target(2), cfg.y_target(3));
fprintf("Propulsion model: %s\n", func2str(cfg.propulsion_model));
fprintf("Steering law: %s\n", func2str(cfg.steering_law));
fprintf("ODE Solver: %s\n", func2str(cfg.solver));
   

end