function [P, dPdy] = penalty(y, pen_param, rpmin)
% k is a penalty scaling parameter, not to be confused with the MEE value k

[p, f, g, ~, ~, ~] = unpack_mee(y);

% Calculate periapsis radius
rp = p .* (1 - sqrt(f.^2+g.^2)) ./ (1 - f.^2 - g.^2);
P = exp(pen_param*(1 - rp ./ rpmin));

% These partials were calculated using symbolic math
dPdf = (f .* pen_param .* p .* exp(-pen_param.*(p ./ (rpmin .* (sqrt(f.^2+g.^2) + 1.0)) - 1.0)) .* 1.0 ./ (sqrt(f.^2+g.^2) + 1.0).^2 .* 1.0 ./ sqrt(f.^2+g.^2)) ./ rpmin;
dPdg = (g .* pen_param .* p .* exp(-pen_param.*(p ./ (rpmin .* (sqrt(f.^2+g.^2) + 1.0)) - 1.0)) .* 1.0 ./ (sqrt(f.^2+g.^2) + 1.0).^2 .* 1.0 ./ sqrt(f.^2+g.^2)) ./ rpmin;
dPdp = -(pen_param .* exp(-pen_param.*(p ./ (rpmin .* (sqrt(f.^2+g.^2) + 1.0)) - 1.0))) ./ (rpmin .* (sqrt(f.^2+g.^2) + 1.0));

dPdy = [dPdp; dPdf; dPdg; 0; 0];

end