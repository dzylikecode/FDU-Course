syms x
fplot(tan(x))
syms w f;
fs = 1000;
H = 1/7 + 2/7*cos(w/fs) + 2/7*cos(2*w/fs) + 2/7*cos(3*w/fs);

H_f = subs(H, w, 2 * pi * f)
fplot(H_f, [-fs/2, fs/2])