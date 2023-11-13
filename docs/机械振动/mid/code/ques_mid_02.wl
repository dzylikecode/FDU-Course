(* ::Package:: *)

ClearAll["Global`*"];
k1 = Subscript[k, 1];
k2 = Subscript[k, 2];
kt = Subscript[k, t];
theta1 = Subscript[\[Theta], 1][t];
omega1 = D[theta1, t]
theta2 = Subscript[\[Theta], 2][t];
omega2 = D[theta2, t]


$Assumptions = {k1 \[Element] Constants, k2 \[Element] Constants, kt \[Element] Constants, L \[Element] Constants, m \[Element] Constants, M \[Element] Constants}


xt = x[t]
PO = {xt, 0}
vPO = D[PO, t]
OA = FromPolarCoordinates[{L, Pi/2 - theta1}]
AB = FromPolarCoordinates[{L, Pi/2 - theta2}]
PO1 = PO + 1/2 OA
vPO1 = D[PO1, t]
PA = PO + OA
PO2 = PA + 1/2 AB
vPO2 = D[PO2, t]


EM = 1/2 M vPO . vPO
Em1 = 1/2 m vPO1 . vPO1 + 1/2 J omega1^2
Em2 = 1/2 m vPO2 . vPO2 + 1/2 J omega2^2
T = EM + Em1 + Em2
T // Simplify // Expand // Simplify


Ek1 = 1/2 k1 xt^2
Ek2 = 1/2 k2 xt^2
Ekt = 1/2 kt theta1^2
Eg1 = m g (L - PO1[[2]])
Eg2 = m g (2 L - PO2[[2]])
V = Ek1 + Ek2 + Ekt + Eg1 + Eg2


Lg = T - V

Needs["VariationalMethods`"]
eularEq = VariationalMethods`EulerEquations[Lg, {xt, theta1, theta2}, t]


PB = PA + AB


(* ::Input:: *)
(**)
