syms t k;
T = sym(pi)
omega = 2*pi/T;
f = sin(t) * exp(-1j * k * omega * t)
1/T * int(f, t, 0, T)