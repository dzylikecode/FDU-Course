(* ::Package:: *)

Clear["Global`*"]
x0 = Subscript[x, 0];
k1 = Subscript[k, 1];
k2 = Subscript[k, 2];
theta1 = Subscript[\[Theta], 1][t];
theta2 = Subscript[\[Theta], 2][t];
m1 = Subscript[m, 1];
m2 = Subscript[m, 2];
N1 = Subscript[N, 1];
N2 = Subscript[N, 2];
Pk1 = {x0, l}
Pk2 = {x0, 2 l}
Pm1 = FromPolarCoordinates[{l, theta1}]
Pm2 = FromPolarCoordinates[{l, theta2}] + Pm1
k1m1 = Pm1 - Pk1
ek1m1 = Normalize[k1m1]
Dk1 = k1m1 - x0 ek1m1
Fk1 = - k1 Dk1
k2m2 = Pm2 - Pk2
ek2m2 = Normalize[k2m2]
Dk2 = k2m2 - x0 ek2m2
Fk2 = - k2 Dk2


Ftm1o = FromPolarCoordinates[{-N1, theta1}]
Ftm1m2 = FromPolarCoordinates[{N2, theta2}]
Ftm2m1 = - Ftm1m2


G1 = {0, m1 g}
G2 = {0, m2 g}

Feq1 = Ftm1o + Ftm1m2 + Fk1 + G1 == m1 D[Pm1, {t, 2}]


Feq2 = Ftm2m1 + Fk2 + G2 == m2 D[Pm2, {t, 2}]


(*Eliminate[{Feq1, Feq2}, {N1, N2}]*)
Feq1x = Feq1[[1, 1]] == Feq1[[2, 1]]
Feq1y = Feq1[[1, 2]] == Feq1[[2, 2]]
Feq2x = Feq2[[1, 1]] == Feq2[[2, 1]]
Feq2y = Feq2[[1, 2]] == Feq2[[2, 2]]


N2sol = Solve[Feq2y, {N2}]
N1sol = Solve[(Feq1y /. N2sol), {N1}]
theta1eq = Feq1x /. N1sol
theta2eq = Feq2x /. N2sol



