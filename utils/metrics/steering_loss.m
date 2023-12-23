function err = steering_loss(y, y_target, weights)
%STEERING_LOSS  Steering loss to target element set
%  err = steering_loss(y, y_target) computes the steering loss to the
%  target element set y_target from the current element set y.
%
%  Inputs:
%    y = [p; f; g; h; k; L] = current element set
%    y_target = [p; f; g; h; k] = target element set
%
%  Outputs:
%    err = steering loss to target element set

[p, f, g, h, k, ~] = unpack_mee(y);

p_diff_norm = (p - y_target(1)) / 6378e3;
err = vecnorm([p_diff_norm; f - y_target(2); g - y_target(3); ...
    h - y_target(4); k - y_target(5)] .* weights, 2, 1);

end