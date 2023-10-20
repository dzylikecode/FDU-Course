(* ::Package:: *)

m1 = Subscript[m, 1];
m2 = Subscript[m, 2];
theta1 = Subscript[\[Theta], 1][t];
theta2 = Subscript[\[Theta], 2][t];
omega1 = D[theta1, t];
alpha1 = D[omega1, t];
omega2 = D[theta2, t];
alpha2 = D[omega2, t];
approxCond = {Sin[a_] -> a, Cos[a_] -> 1};
Cross2D[a_, b_] := Cross[Append[a, 0], Append[b, 0]][[3]]
k1 = Subscript[k, 1];
k2 = Subscript[k, 2];


G1 = {0, m1 g}
rG1 = {1/2 L, 0}
Dy1 = (3/4 L theta1 - 3/4 L theta2)
Fk1 = {0, - k1 Dy1}
rk1 = {3/4 L, 0}
J1 = 1/3 m1 L^2
eq1 = Cross2D[rk1, Fk1] + Cross2D[rG1, G1] - J1 alpha1 == 0
eq1 // Simplify


G2 = {0, m2 g}
rG2 = {1/4 L, 0}
Fk1 = {0, k1 Dy1}
rk1 = {3/4 L, 0}
Dy2 = 1/2 L theta2
Fk2 = {0, - k2 Dy2}
rk2 = {1/2 L, 0}
J2 = 1/12 m2 L^2 + m2 (L/4)^2
eq2 = Cross2D[rk1, Fk1] + Cross2D[rk2, Fk2] + Cross2D[rG2, G2] - J2 alpha2 == 0
eq2 // Simplify


{eq1, eq2} // Simplify


T = 1/2 J1 omega1^2 + 1/2 J2 omega2^2
W = m1 g L/2 theta1 + m2 g L/4 theta2 + 1/2 k1 Dy1^2 + 1/2 k2 Dy2^2
Lg = T + W

Needs["VariationalMethods`"]
EqEular = VariationalMethods`EulerEquations[Lg, {theta1, theta2}, t]
$Assumptions = {L > 0};
EqEular // Simplify




