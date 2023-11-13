(* ::Package:: *)

ClearAll["Global`*"];
k1 = Subscript[k, 1];
k2 = Subscript[k, 2];
k3 = Subscript[k, 3];
k4 = Subscript[k, 4];
c1 = Subscript[c, 1];
c2 = Subscript[c, 2];
c3 = Subscript[c, 3];
c4 = Subscript[c, 4];


$Assumptions = {k1 \[Element] Constants, k2 \[Element] Constants, k3 \[Element] Constants, k4 \[Element] Constants, 
   c1 \[Element] Constants, c2 \[Element] Constants, c3 \[Element] Constants, c4 \[Element] Constants, L \[Element] Constants, m \[Element] Constants}


qt = q[t]
xt = x[t]
xCart = qt + xt


dx1 = xCart + (-L)
Ek1 = 1/2 k1 dx1^2
dx2 = xCart
Ek2 = 1/2 k2 dx2^2
dx3 = xt
Ek3 = 1/2 k3 dx3^2
dx4 = xt
Ek4 = 1/2 k4 dx4^2


vCart = D[xCart, t]
Ev = 1/2 m vCart^2


Lg = Ev - (Ek1 + Ek2 + Ek3 + Ek4)


Dtw[f_] := D[f, qt] dq + D[f, xt] dx
dWc1 = - c1 D[dx1, t] Dtw[dx1]
dWc2 = - c2 D[dx2, t] Dtw[dx2]
dWc3 = - c3 D[dx3, t] Dtw[dx3]
dWc4 = - c4 D[dx4, t] Dtw[dx4]
dw = dWc1 + dWc2 + dWc3 + dWc4 // Expand
dwqx = Collect[dw, {dq, dx}]
coeffDq = Coefficient[dw, dq]
coeffDx = Coefficient[dw, dx]


Needs["VariationalMethods`"]
eularEq = VariationalMethods`EulerEquations[Lg, {qt, xt}, t]

eularEq = -eularEq[[2, 1]] == coeffDx
eularEq// Simplify


eularEq /. qt -> Q Cos[\[Omega]t]


qt = Q Cos[\[Omega] t]
F = - m D[qt, {t, 2}] + (c1 + c2) D[qt, t] - (k1 + k2) qt


f = L/4 + (3 L)/(4 T) t
omega = (2 Pi)/T
$Assumptions = {n \[Element] Integers}
2/T Integrate[f, {t, 0, T}]
2/T Integrate[f Cos[n omega t], {t, 0, T}]
2/T Integrate[f Sin[n omega t], {t, 0, T}]


f = (3 L)/(4 T)
2/T Integrate[f, {t, 0, T}]
2/T Integrate[f Cos[n omega t], {t, 0, T}]
2/T Integrate[f Sin[n omega t], {t, 0, T}]



