function [p, f, g, L] = unpack_mee(m)
% Unpacks either 1-D or 2-D array into individual elements or rows.
p = m(1, :);
f = m(2, :);
g = m(3, :);
L = m(4, :);
end
