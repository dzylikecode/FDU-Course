clear; clc;
m = 1;
c = 0.2;
k = 10;
omega_n = sym(sqrt(k/m))

xi = sym(c / (2* sqrt(m*k)))
omega_d = sqrt(1-xi^2)*omega_n
syms t
g = exp(-xi*omega_n*t)/(m*omega_d)*sin(omega_d*t)
f = piecewise(0 < t & t <= 2, 3*t, 2 < t & t <= 8, 8 - t)
fplot(f, [0, 8])
syms tau
int_f = subs(f, t, tau) * subs(g, t, t - tau)
x = int(int_f, tau, 0, t)
fplot(x, [0, 8])