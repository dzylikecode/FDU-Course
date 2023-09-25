%% HOMEWORK 1
%% 
% 
%% implicit function differentiation

clear;
syms t omega_d u(t)
f(t) = u(t) * exp(-omega_d*t)
diff(f)
%%
clear;
syms t x(t) p q r u(t)
f = @(v) diff(v, 2) + p * diff(v, 1) + q * v;
f(x)
x_1 = exp(r * t);
eq_1 = f(x_1) == 0;
simplify(eq_1)
x_2 = u*exp(r * t);
eq_2 = f(x_2) == 0;
simplify(eq_2)
eq_3 = 2*r + p == 0
eq_4 = diff(u, 2) == 0
dsolve(eq_4)
%%
dsolve(diff(u, 2) == 0)