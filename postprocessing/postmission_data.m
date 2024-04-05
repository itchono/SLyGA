 function postmission_data(t, y, cfg)
% WIP function to show that eclipse is actually happening (dips in
% brightness)

[y_interp, t_interp] = interp_mee(y, t, 5000);

illuminated = zeros(length(t_interp), 1);

for j = 1:length(t_interp)
    illuminated(j) = calculate_eclipsed(t_interp(j), y_interp(:, j));
end

plot(t_interp, illuminated)

    
end