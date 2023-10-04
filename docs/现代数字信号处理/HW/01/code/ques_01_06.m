clear;clc;
syms t alpha
T = 2;
x = piecewise(-T/2 <= t & t <= T/2,  alpha*exp(t))
omega = sym(2*pi/T)
syms n
assume(n, 'integer');
c_n = 1/T*int(x*exp(-1i*n*omega*t), t, -T/2, T/2);
c_n = simplify(c_n)
A_n = abs(c_n);
A_n = simplify(A_n)
varphi_n = angle(c_n)
varphi_n = simplify(varphi_n)
assume(alpha == 1);
A_n = simplify(A_n)
varphi_n = simplify(varphi_n)
n_s = -10:10
A_n_f = matlabFunction(A_n);
A_n_s = A_n_f(n_s)
stem(n_s, A_n_s);
xlabel('n');
ylabel('Amplitude');
title('Amplitude of $x(t)$', 'Interpreter','Latex');
varphi_n_f = matlabFunction(varphi_n);
varphi_n_s = rad2deg(varphi_n_f(n_s))
stem(n_s, varphi_n_s)
y_ticks = [-120, -90, -45, 0, 45, 90, 120];
yticks(y_ticks);
yticklabels(string(y_ticks) + "^\circ");
xlabel('n');
ylabel('Angle');
title('Phase of $x(t)$', 'Interpreter','Latex');