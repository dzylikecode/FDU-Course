(* ::Package:: *)

uList = Map[Subscript[u, #]&, {0, 1, 2}]
{u0, u1, u2} = uList

utList = Map[#[t]&, uList]
{u0t, u1t, u2t} = utList



bList = Map[Subscript[b, #]&, {1, 2}]
{b1, b2} = bList

e = \[Epsilon]

w = \[Omega]

w0 = Subscript[w, 0]

a = a

t = t

uet = u0t + e u1t + e^2 u2t
we2 = w02 + e b1 + e^2 b2

$Assumptions = { 
	u0t \[Element] Reals, u1t \[Element] Reals, u2t \[Element] Reals, 
	b1 \[Element] Reals, b2 \[Element] Reals,
	w0 \[Element] Reals, e \[Element] Reals, w \[Element] Reals,
	a \[Element] Reals, t > 0
	}


w0Sol = Solve[we2 - w^2 == 0, {w02}]


eq[u_] := D[u, {t, 2}] + w02 u + e u^2


eqSubs = eq[uet] /. w0Sol[[1]]


expandedExpr = ExpandAll[eqSubs]


constantTerm = Coefficient[expandedExpr, e, 0];


e1Coefficient = Coefficient[expandedExpr, e, 1];


e2Coefficient = Coefficient[expandedExpr, e, 2];
constantTerm 
e1Coefficient
e2Coefficient


u0Sol = {{u0t -> a Cos[w t]}}

diffEq1 = e1Coefficient == 0 /. u0Sol[[1]] // TrigReduce


exEq1 = diffEq1[[1]] /. {u1t -> 0, u2t -> 0, u1''[t] -> 0, u2''[t] -> 0} // TrigReduce
coswtEq1 = Coefficient[exEq1, Cos[w t], 1]
b1Sol = Solve[coswtEq1 == 0, {b1}]
diffEq1 = diffEq1 /. b1Sol (*\:89e3\:51b3\:6c38\:5e74\:9879*)


DSolve[diffEq1, u1t, t] // Simplify


u1Sol = DSolve[{diffEq1, u1'[0] == 0, u1[0] == 0}, u1t, t] // Simplify // TrigReduce


diffEq2 = e2Coefficient == 0 /. u0Sol[[1]] /. u1Sol[[1]]
exEq2 = diffEq2[[1]] /. {u1t -> 0, u2t -> 0, u1''[t] -> 0, u2''[t] -> 0} // TrigReduce
coswtEq2 = Coefficient[exEq2, Cos[w t], 1] /. b1Sol
b2Sol = Solve[coswtEq2 == 0, {b2}]
diffEq2 = diffEq2 /. b1Sol /. b2Sol


DSolve[diffEq2, u2t, t] // Simplify


u2Sol = DSolve[{diffEq2, u2'[0] == 0, u2[0] == 0}, u2t, t] // Simplify // TrigReduce
