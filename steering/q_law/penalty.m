function [P, dPdy] = penalty(y, k, rpmin)
% k is a penalty scaling parameter, not to be confused with the MEE value k

[p, f, g, ~, ~, ~] = unpack_mee(y);

% Calculate periapsis radius
rp = p .* (1-sqrt(f.^2 + g.^2)) ./ (1-f.^2 - g.^2);
P = exp(k * (1-rp./rpmin));

% These partials were calculated using symbolic math
dPdf = (f.*k.*p.*exp(-k.*(p./(rpmin.*(sqrt(f.^2+g.^2)+1.0))-1.0)).*1.0./(sqrt(f.^2+g.^2)+1.0).^2.*1.0./sqrt(f.^2+g.^2))./rpmin;
dPdg = (g.*k.*p.*exp(-k.*(p./(rpmin.*(sqrt(f.^2+g.^2)+1.0))-1.0)).*1.0./(sqrt(f.^2+g.^2)+1.0).^2.*1.0./sqrt(f.^2+g.^2))./rpmin;
dPdp = -(k.*exp(-k.*(p./(rpmin.*(sqrt(f.^2+g.^2)+1.0))-1.0)))./(rpmin.*(sqrt(f.^2+g.^2)+1.0));

dPdy = [dPdf; dPdg; dPdp; 0; 0];

end