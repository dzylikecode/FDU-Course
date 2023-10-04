clear;clc;
syms t
T = 2;
x = piecewise(-T/2 <= t & t <= T/2,  sqrt(1 - t^2))
omega = sym(2*pi/T)
syms n
assume(n, 'integer');
c_n = 1/T*int(x*exp(-1i*n*omega*t), t, -T/2, T/2);
c_n = simplify(c_n)
c_0 = 1/T*int(x, t, -T/2, T/2)
A_n_square = abs(c_n)^2;
A_n_square = simplify(A_n_square)
A_n_square = piecewise(n == 0, c_0^2, n ~= 0, A_n_square) % A_n_square(0) will return NaN
n_s = -20:20
A_n_square_f = @(n_s) arrayfun(@(n) double(subs(A_n_square)), n_s);
A_n_square_s = A_n_square_f(n_s)
sum_A_square = sum(A_n_square_s)
err = abs(sum_A_square - 2/3) / (2/3) * 100;
disp(err + "%")