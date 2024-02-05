function yp = n2_cartesian(y, f_app_lvlh)
% EOM_CARTESIAN Cartesian two-body EoM (Newton's Second Law)
% f_app in LVLH
% y as cartesian

y_mee = cartesian2mee(y);
CIO = rot_inertial_LVLH(y_mee);

f_app_i = CIO * f_app_lvlh;

mu = 3.986e14;
yp = [y(4:6); ...
    -mu/norm(y(1:3)).^3 * y(1:3) + f_app_i;];

end
