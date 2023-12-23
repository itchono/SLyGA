function plot_from_ext(filename)

t_y = readmatrix(filename);
t = t_y(:, 1);
y = (t_y(:, 2:7))';

plot_everything(y, t, [25000e3; 0.2; 0.5; 0; 0.3]);

end