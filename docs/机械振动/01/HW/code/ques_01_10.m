x_list = [14.88, 12.99, 11.49, 10.56, 9.16, 7.85, 7.04, 5.96];
x_tail = x_list(2:end)
x_init = x_list(1:end-1)
x_pre_div_nxt = x_init ./ x_tail
ems_ln_x = log(x_pre_div_nxt)
syms xi
eqs = 2*pi*xi/sqrt(1-xi^2) == mean(ems_ln_x)
double(solve(eqs))