(* ::Package:: *)

Clear["Global`*"]
k1 = Subscript[k, 1];
k2 = Subscript[k, 2];
theta1 = Subscript[\[Theta], 1][t];
theta2 = Subscript[\[Theta], 2][t];
m1 = Subscript[m, 1];
m2 = Subscript[m, 2];
N1 = Subscript[N, 1];
N2 = Subscript[N, 2];
Pm1 = FromPolarCoordinates[{l, Pi/2 - theta1}]
v1 = D[Pm1, t]
a1 = D[v1, t]
Pm2 = FromPolarCoordinates[{l, Pi/2 - theta2}] + Pm1
v2 = D[Pm2, t]
a2 = D[v2, t]
Dk1 = { Pm1[[1]], 0}
Fk1 = - k1 Dk1
Dk2 = { Pm2[[1]], 0}
Fk2 = - k2 Dk2


Ftm1o = FromPolarCoordinates[{-N1, theta1}]
Ftm1m2 = FromPolarCoordinates[{N2, theta2}]
Ftm2m1 = - Ftm1m2


G1 = {0, m1 g}
G2 = {0, m2 g}

Feq1 = Ftm1o + Ftm1m2 + Fk1 + G1 == m1 a1


Feq2 = Ftm2m1 + Fk2 + G2 == m2 a2


(*Eliminate[{Feq1, Feq2}, {N1, N2}]*)
Feq1x = Feq1[[1, 1]] == Feq1[[2, 1]]
Feq1y = Feq1[[1, 2]] == Feq1[[2, 2]]
Feq2x = Feq2[[1, 1]] == Feq2[[2, 1]]
Feq2y = Feq2[[1, 2]] == Feq2[[2, 2]]


N2sol = Solve[Feq2y, {N2}]
N1sol = Solve[(Feq1y /. N2sol), {N1}]
theta1eq = Feq1x /. N1sol // Simplify
theta2eq = Feq2x /. N2sol // Simplify


testCond = {theta1 -> 0, theta2 -> 0}
theta1eq[[1]] Cos[theta1]


T = 1/2 m1 v1 . v1 + 1/2 m2 v2 . v2 
(* \:96f6\:52bf\:80fd\:9762\:53ef\:4ee5\:968f\:4fbf\:53d6, \:505a\:6b63\:529f, \:5219\:52bf\:80fd\:4e0b\:964d, \:6216\:8005\:4ece\:505a\:529f\:89d2\:5ea6\:8003\:8651, T + W, \:4e0d\:59a8\:53d6\:5e73\:8861\:70b9\:4e3a\:96f6\:52bf\:80fd\:9762 *)
V = 1/2 k1 Dk1 . Dk1 + 1/2 k2 Dk2 . Dk2 + m1 g (l - Pm1[[2]]) - m2 g (2 l - Pm2[[2]])
Lg = T - V


Needs["VariationalMethods`"]
EqEular = VariationalMethods`EulerEquations[Lg, {theta1, theta2}, t] // Simplify


approxCond = {Sin[a_] -> a, Cos[a_] -> 1}
EqEular /. approxCond // Simplify



