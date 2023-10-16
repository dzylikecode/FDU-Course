(* ::Package:: *)

k1 = Subscript[k, 1];
k2 = Subscript[k, 2];
Fk1 = - k1 x1


x1 = L - L Cos[\[Theta][t]]


ddotx = D[x1, {t, 2}]


Fk2 = - k2 y2


y2 = L Sin[\[Theta][t]]
ddoty = D[y2, {t, 2}]


Fax = -m ddotx


Fay = -m ddoty


G = m g


N2 = Subscript[N, 2];
N1 = Subscript[N, 1];
Fx = Fk1 + Fax + N2 == 0
Fx // Simplify


N2sol = Solve[Fx, {N2}]


Fy = 
