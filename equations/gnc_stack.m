function yp = gnc_stack(t, y)

if t < 5000
    f_app = [0; 0];
elseif t < 10000
    f_app = [0; 0.1];
else
    f_app = [0; 0];
end

yp = eom_gve_moe(t, y, f_app);

end
