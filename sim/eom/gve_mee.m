function yp = gve_mee(~, y, f_app)
% GVE_MEE  Gauss variational equations in modified equinoctial elements
%   yp = gve_mee(t, y, f_app) implements the Gauss variational equations
%   in modified equinoctial elements. The equations are implemented as a
%   system of first order differential equations.
%
%   Inputs:
%       t       Time (s)
%       y       State vector (modified equinoctial elements)
%       f_app   Perturbing acceleration (m/s^2)
%
%   Outputs:
%       yp      Derivative of state vector (modified equinoctial elements)

[p, f, g, L] = unpack_mee(y);

% Shorthands
q = 1 + f * cos(L) + g * sin(L);
mu = 3.986e14;

% Implement differential equation
leading_coeff = 1/q * sqrt(p/mu);
A = leading_coeff * [0, 2.*p;
    q.*sin(L), (q+1).*cos(L) + f;
    -q.*cos(L), (q+1).*sin(L) + g;
    0, 0];
b = [0; 0; 0; q.^2 .* sqrt(mu .* p) ./ p.^2];

yp = A * f_app + b;
end