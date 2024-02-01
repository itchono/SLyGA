function yp = eom_cartesian(y, f_app_lvlh)
% EOM_CARTESIAN Cartesian two-body EoM
% f_app in LVLH

[p, f, g, h, k, L] = unpack_mee(y);

CIO = rot_inertial_LVLH(p, f, g, h, k, L);

f_app_i = CIO * f_app_lvlh;

yp = zeros(length(y), 1);

mu = 3.986e14;
yp(1:3) = y(3:6);
yp(3:6) = -mu/norm(y(1:3)).^3 * y(1:3) + f_app_i;

end
