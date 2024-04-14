function [alpha, beta] = on_off_steering(t, y, ~)
% Reference steering law from McInnes 4.4.2.1; to debug simulator
% Untested in 3D sims; used only early on in development

[~, ~, ~, ~, ~, L] = unpack_mee(y);
phi_sun = sun_angle(t);
gamma_candidate = L - phi_sun - pi / 2;

if sin(L-phi_sun) > 0
    alpha = gamma_candidate;
else
    alpha = L - phi_sun;
end

beta = 0;

end