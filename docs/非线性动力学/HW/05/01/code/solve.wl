(* ::Package:: *)

{u0, u1, u2} = Map[Subscript[u, #][t]&, {0, 1, 2}]
{u0S, u1S, u2S} = Map[Subscript[u, #]&, {0, 1, 2}]

e = \[Epsilon]

w = \[Omega]

a = a

t = t

$Assumptions = { u0 \[Element] Reals, u1 \[Element] Reals, u2 \[Element] Reals, w \[Element] Reals, e \[Element] Reals, a \[Element] Reals, t > 0}

uet = u0 + e u1 + e^2 u2


eq[u_] := D[u, {t, 2}] + u + e u^2


eqSubs = eq[uet]


expandedExpr = ExpandAll[eqSubs]


constantTerm = Coefficient[expandedExpr, e, 0]


e1Coefficient = Coefficient[expandedExpr, e, 1]


e2Coefficient = Coefficient[expandedExpr, e, 2]


u0Sol = {{u0 -> a Cos[t]}}

diffEq1 = e1Coefficient == 0 /. u0Sol[[1]]


DSolve[diffEq1, u1, t] // Simplify


u1Sol = DSolve[{diffEq1, u1S'[0] == 0, u1S[0] == 0}, u1, t] // Simplify // TrigReduce


diffEq2 = e2Coefficient == 0 /. u0Sol[[1]] /. u1Sol[[1]]


DSolve[diffEq2, u2, t] // Simplify


u2Sol = DSolve[{diffEq2, u2S'[0] == 0, u2S[0] == 0}, u2, t] // Simplify // TrigReduce
