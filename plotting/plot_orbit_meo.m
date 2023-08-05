function plot_orbit_meo(p, f, g, L, t)
% plot_orbit_meo(p, f, g, L) plots an orbit in modified equinoctial
% elements. The arguments may be vectorized, but they must be rows if this
% is the case.
% 
% Plots the Earth at (0, 0)
%
% Accepts an optional time argument for colouring the line, otherwise it
% colours using sample number

% convert position to Cartesian
pos = meo2cartesian(p, f, g, L);

% plot the "earth" and the orbit
plot(0, 0, "bo");
hold on

x = pos(1, :);
y = pos(2, :);
z = zeros(size(x));

if nargin == 5
    time = t;
else
    time = 1:length(x);
end
% hack to plot a coloured line
% https://www.mathworks.com/matlabcentral/answers/5042-how-do-i-vary-color-along-a-2d-line#answer_7057
surface([x;x],[y;y],[z;z],[time;time],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
axis equal;
title("Earth Inertial Coordinates");
xlabel("x (m)")
ylabel("y (m)")
colorbar

end



