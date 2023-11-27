function [P, dPdy] = penalty(y, k, rpmin)
[p, f, g, ~, ~, ~] = unpack_mee(y);

rp = p .* (1-sqrt(f.^2 + g.^2)) ./ (1-f.^2 - g.^2);
P = exp(k * (1-rp./rpmin));

dPdf = (f.*k.*p.*exp(-k.*(p./(rpmin.*(sqrt(f.^2+g.^2)+1.0))-1.0)).*1.0./(sqrt(f.^2+g.^2)+1.0).^2.*1.0./sqrt(f.^2+g.^2))./rpmin;
dPdg = (g.*k.*p.*exp(-k.*(p./(rpmin.*(sqrt(f.^2+g.^2)+1.0))-1.0)).*1.0./(sqrt(f.^2+g.^2)+1.0).^2.*1.0./sqrt(f.^2+g.^2))./rpmin;
dPdp = -(k.*exp(-k.*(p./(rpmin.*(sqrt(f.^2+g.^2)+1.0))-1.0)))./(rpmin.*(sqrt(f.^2+g.^2)+1.0));
dPdy = [dPdf; dPdg; dPdp; 0; 0];

end