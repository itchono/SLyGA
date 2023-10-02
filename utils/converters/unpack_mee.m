function [p, f, g, h, k, L] = unpack_mee(m)
% UNPACK_MEE  Unpacks MEE vector into individual elements.
%
%   [p, f, g, h, k, L] = UNPACK_MEE(m) unpacks the MEE vector m into the
%   individual elements p, f, g, h, k, L
%
% Inputs:
%   m - MEE vector
%
% Outputs:
%   p, f, g, h, k, L - individual elements of MEE vector

% Unpacks either 1-D or 2-D array into individual elements or rows.
p = m(1, :);
f = m(2, :);
g = m(3, :);
h = m(4, :);
k = m(5, :);
L = m(6, :);
end
