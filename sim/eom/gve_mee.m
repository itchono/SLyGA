function yp = gve_mee(y, f_app)
% GVE_MEE  Gauss variational equations in modified equinoctial elements
%   yp = gve_mee(t, y, f_app) implements the Gauss variational equations
%   in modified equinoctial elements. The equations are implemented as a
%   system of first order differential equations.
%
%   Inputs:
%       y       State vector (modified equinoctial elements)
%       f_app   Perturbing acceleration (m/s^2)
%
%   Outputs:
%       yp      Derivative of state vector (modified equinoctial elements)

[A, b, ~] = gve_coeffs(y);

yp = A * f_app + b;

end