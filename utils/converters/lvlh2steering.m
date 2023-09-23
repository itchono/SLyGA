function [alpha, beta] = lvlh2steering(n_lvlh)
% Converts a direction vector in LVLH into alpha and beta steering angles

    beta = atan2(n_lvlh(3), sqrt(n_lvlh(1).^2 + n_lvlh(2).^2));
    alpha = atan2(n_lvlh(1), n_lvlh(2));
end