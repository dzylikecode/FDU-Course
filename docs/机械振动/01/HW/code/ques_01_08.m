clear; clc;
m = 1;
c = 0.2;
k = 10;
omega_n = sym(sqrt(k/m))

xi = sym(c / (2* sqrt(m*k)))
omega_d = sqrt(1-xi^2)*omega_n
syms t
g = exp(-xi*omega_n*t)/(m*omega_d)*sin(omega_d*t)
f = piecewise(0 <= t & t <= 2, 3*t, 2 < t & t <= 8, 8 - t, t>8|t<0, 0)
fplot(f, [0, 8])
syms tau
int_f = subs(f, t, tau) * subs(g, t, t - tau)
x = int(int_f, tau, 0, t)
fplot(x, [0, 8])
h = piecewise(0 < t , 1)
syms tau
int_mat_int_f = tau*h*subs(g, t, t-tau)
res_template = int(int_mat_int_f, tau, 0, t)
res_f = 3*subs(res_template, t, t) - 4*subs(res_template, t, t-2) + subs(res_template, t, t-8)
fplot(res_f, [0, 8])
h = heaviside(t)
x = 1/k*(t-2*xi/omega_n+exp(-xi*omega_n*t)*(2*xi/omega_n*cos(omega_d*t)-(omega_d^2-xi^2*omega_n^2)/(omega_n^2*omega_d)*sin(omega_d*t)))
res_template = x*h
res_f = 3*subs(res_template, t, t) - 4*subs(res_template, t, t-2) + subs(res_template, t, t-8)
f_1 = subs(res_template, t, t)
fplot(f_1, [0, 3])
fplot(res_f, [0, 8])

syms t omega_n omega_d xi k
h = piecewise(0 <= t , 1)
x = 1/k*(t-2*xi/omega_n+exp(-xi*omega_n*t)*(2*xi/omega_n*cos(omega_d*t)-(omega_d^2-xi^2*omega_n^2)/(omega_n^2*omega_d)*sin(omega_d*t)))


syms t omega_n m xi omega_d
g = exp(-xi*omega_n*t)/(m*omega_d)*sin(omega_d*t)
test_f = piecewise(0 < t , t)
int_test_f = subs(test_f, t, tau) * subs(g, t, t - tau)
test_res = simplify(int(int_test_f, tau, 0, t))
test_res_subs = subs(test_res, t, t-2)
fplot(h, [-2, 2])