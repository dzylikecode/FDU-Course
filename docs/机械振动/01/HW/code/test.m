clear; clc;
m = 1;
c = 0.2;
k = 10;
omega_n = sym(sqrt(k/m))
xi = sym(c / (2* sqrt(m*k)))
omega_d = sqrt(1-xi^2)*omega_n
syms t
g = exp(-xi*omega_n*t)/(m*omega_d)*sin(omega_d*t)
u = piecewise(t>=0, 1, t<0, 0)
fplot(u, [-1, 2])
double(subs(u, -1))
f = u*t
syms tau
int_f = subs(f, t, tau)*subs(g, t, t-tau)
res_f = int(int_f, tau, 0, t)
fplot(res_f, [0, 2])
res_final = 3*subs(res_f, t, t) - 4*subs(res_f, t-2) + subs(res_f, t, t-8)
fplot(res_final, [0, 8])
x = 1/k*(t-2*xi/omega_n+exp(-xi*omega_n*t)*(2*xi/omega_n*cos(omega_d*t)-(omega_d^2-xi^2*omega_n^2)/(omega_n^2*omega_d)*sin(omega_d*t)))*u
fplot(x, [0, 2])
eq = simplify(x - res_f)