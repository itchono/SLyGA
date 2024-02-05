s_cart = [1e6 2e6; 2e6 3e6; 3e6 4e6; 4e3 5e3; 5e3 6e3; 6e3 7e3];
m = cartesian2mee(s_cart);
cart2 = mee2cartesian(m);

err = s_cart - cart2;
norm(err)