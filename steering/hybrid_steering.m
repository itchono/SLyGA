function [alpha, beta] = hybrid_steering(t, y, y_tgt)

if t > 1e5
    [alpha, beta] = lyapunov_steering(t, y, y_tgt);
else
    [alpha, beta] = linear_steering(t, y, y_tgt);
end
end

