(* ::Package:: *)

alpha= \[Alpha];

$Assumptions = {A > 0, B > 0, C > 0, D > 0, alpha > 0, EI > 0, M > 0, k > 0, L > 0 };

W = A Cos[alpha x] + B Sin[alpha x] + C Cosh[alpha x] + D Sinh[alpha x]


dW = D[W, {x}]
ddW = D[W, {x, 2}]
dddW = D[W, {x, 3}]


eq1 = (EI ddW /. x -> 0) == 0 // Simplify
eq2 = (EI dddW /. x -> 0) == - (M ddW /. x-> 0) // Simplify


eq3 = (W /. x -> L) == 0 // Simplify
eq4 = (EI ddW /. x -> L) == - (k dW /. x-> L) // Simplify



subs = {k -> EI/L, M -> 2mL}
eq = {eq1, eq2, eq3, eq4}

eq /. subs // Simplify
