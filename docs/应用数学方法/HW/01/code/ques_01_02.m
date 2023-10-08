syms x y A B n m
eq1 = A - (B+1)*x + x^2*y
eq2 = B*x - x^2*y
eq1_new = subs(eq1, [x, y], [A + n, A/B + m]);
eq1_new = sort(expand(eq1_new))
eq2_new = subs(eq2, [x, y], [A + n, A/B + m]);
eq2_new = sort(expand(eq2_new))