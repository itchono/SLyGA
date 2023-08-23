function gamma = on_off_steering(t, y, ~)
% Reference steering law from McInnes 4.4.2.1; to debug simulator

[~, ~, ~, L] = unpack_mee(y);
phi_sun = sun_angle(t);
gamma_candidate = L - phi_sun - pi / 2;

if sin(L-phi_sun) > 0
    gamma = gamma_candidate;
else
    gamma = L - phi_sun;
end


end