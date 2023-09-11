function lvlh = steering2lvlh(alpha, beta)
% Converts alpha and beta steering angles into a direction vector in LVLH

lvlh = [cos(beta) * sin(alpha); ...
    cos(beta) * cos(alpha); ...
    sin(beta);];
end