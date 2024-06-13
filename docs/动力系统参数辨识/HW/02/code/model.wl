(* ::Package:: *)

Clear["Global`*"]
Needs["VariationalMethods`"]
theta2 = Subscript[\[Theta], 2][t];
theta3 = Subscript[\[Theta], 3][t];
omega2 = D[theta2, t];
omega3 = D[theta3, t];
d2 = Subscript[d, 2];
d3 = Subscript[d, 3];
l2 = Subscript[l, 2];
l3 = Subscript[l, 3];
m2 = Subscript[m, 2];
m3 = Subscript[m, 3];
J2 = Subscript[J, 2];
J3 = Subscript[J, 3];
$Assumptions = {
	l2 > 0, l3 > 0, 
	g > 0, 
	d2 > 0, d3 > 0,
	m2 > 0, m3 > 0,
	J2 > 0, J3 > 0
};


absTheta3 = theta2 + theta3
absOmega3 = D[absTheta3, t]
x2 = -l2 Sin[theta2]
y2 = l2 Cos[theta2]
x3 = -d2 Sin[theta2] + l3 Cos[absTheta3]
y3 = d2 Cos[theta2] + l3 Sin[absTheta3]


dx2 = D[x2, t]
dy2 = D[y2, t]
dx3 = D[x3, t]
dy3 = D[y3, t]


Ek = 1/2 m2 (dx2^2 + dy2^2) + 1/2 J2 omega2^2 + 1/2 m3 (dx3^2 + dy3^2) + 1/2 J3 absOmega3^2


Ev = m2 g y2 + m3 g y3


lag = Ek - Ev


ode = VariationalMethods`EulerEquations[lag, {theta2, theta3}, t]
eq1 = -ode[[1, 1]] // Expand // Simplify
eq2 = -ode[[2, 1]] // Expand // Simplify


alpha2 = D[omega2, t]
alpha3 = D[omega3, t]
Collect[eq2, {alpha2, alpha3, omega2, omega3, theta2, theta3}] 


Collect[eq1, {alpha2, alpha3, omega2, omega3, theta2, theta3}] 
