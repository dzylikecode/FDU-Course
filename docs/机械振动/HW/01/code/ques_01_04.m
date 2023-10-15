m = 1750;
c = 3500;
k = 7*10^5;
a = 0.9;
b = 2;


omega_n = a/b*sqrt(k/m)
pretty(sym(omega_n))
xi = (b*c)/(2*a*sqrt(m*k))
pretty(sym(xi))
omega_d = sqrt(1-xi^2)*omega_n
2*a*sqrt(m*k)/b