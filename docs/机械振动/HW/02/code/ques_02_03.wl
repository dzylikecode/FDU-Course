(* ::Package:: *)

k1 = Subscript[k, 1];
k2 = Subscript[k, 2];
theta = \[Theta][t];


x1 = L - L Cos[theta]
Fk1 = {- k1 x1, 0}
y2 = L Sin[theta]
Fk2 = {0, - k2 y2}


a = D[{x1 + 1/2 L Cos[theta], 1/2 y2}, {t, 2}]
Fa = m a


G = {0, m g}


N2 = Subscript[N, 2];
N1 = Subscript[N, 1];
FN1 = {0, -N1}
FN2 = {N2, 0}


Feq = Fk1 + Fk2 + G + FN1 + FN2 - Fa == 0
Fsol = Solve[Feq, {N1, N2}]


J = 1/12 m L^2
Mtheta = J D[theta, {t, 2}]
Cross2D[a_, b_] := Cross[Append[a, 0], Append[b, 0]][[3]]
rk1 = FromPolarCoordinates[{ - (L/2), theta}]
Mk1 = Cross2D[rk1, Fk1]
MN1 = Cross2D[rk1, FN1]
rk2 = FromPolarCoordinates[{ L/2, theta}]
Mk2 = Cross2D[rk2, Fk2]
MN2 = Cross2D[rk2, FN2]


Meq = Mk1 + Mk2 + MN1 + MN2 - Mtheta == 0
Meq /. Fsol // Simplify
vc = 1/2 L D[theta, t]
T = 1/2 m vc^2 + 1/2 J D[theta, t]^2
V = 1/2 k1 x1^2 + 1/2 k2 y2^2 - mg y2/2
Lg = T - V


(* ::Text:: *)
(*https://mathematica.stackexchange.com/questions/261436/solving-lagrangian-with-mathematica*)


Needs["VariationalMethods`"]
VariationalMethods`EulerEquations[Lg, theta, t]
