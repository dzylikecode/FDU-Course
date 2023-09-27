x_list = [14.88, 12.99, 11.49, 10.56, 9.16, 7.85, 7.04, 5.96];
x_tail = x_list(2:end)
x_init = x_list(1:end-1)
x_pre_div_nxt = x_init ./ x_tail
ems_ln_x = log(x_pre_div_nxt)
syms xi
eqs = 2*pi*xi/sqrt(1-xi^2) == mean(ems_ln_x)
res_xi_1= double(solve(eqs))
%% the solution above is wrong, the following is better
y = log(x_list)
n = 1:length(y)
p = polyfit(n, y, 1)
a = p(1); b = p(2);
f = @(x) a*x + b;
fplot(f, [0, 9])
hold on;
plot(n, y, 'ro')
res_xi_2 = double(solve(a == -2*pi*xi/sqrt(1-xi^2)))
err = abs(res_xi_2 - res_xi_1) / res_xi_2 * 100;
disp(err + "%");