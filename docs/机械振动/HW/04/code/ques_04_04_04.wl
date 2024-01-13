(* ::Package:: *)

ClearAll["Global`*"]
alpha= \[Alpha];
$Assumptions = {A \[Element] Reals, B \[Element] Reals, C \[Element] Reals, D \[Element] Reals, alpha > 0, EI > 0, M > 0, k > 0, L > 0, EI > 0 };

W = A Sin[alpha x] + B Cos[alpha x] + C Sinh[alpha x] + D Cosh[alpha x]


dW = D[W, {x}]
ddW = D[W, {x, 2}]
dddW = D[W, {x, 3}]


omega = \[Omega];
littleW = W Exp[I omega t]

ppWx = D[littleW, {x, 2}]

ppWt = D[littleW, {t, 2}]

eq1 = (W /. x -> 0) == 0 // Simplify
eq2 = (EI ddW /. x -> 0) == 0 // Simplify


eq3 = (EI W /. x -> L) == 0 // Simplify
eq4 = (EI ddW /. x -> L) == (- k dW /. x -> L) // Simplify


eq = {eq1, eq2, eq3, eq4} /. {k -> EI/L} // Simplify

eq // Simplify

eq31 = eq[[3]] /. {B -> 0, D -> 0} // Simplify
eq41 = eq[[4]] /. {B -> 0, D -> 0} // Simplify

eqalpha = { {Sin[L alpha], Sinh[alpha L]},
			{-L alpha Sin[L alpha] + Cos[alpha L], L alpha Sinh[alpha L] + Cosh[alpha L]}
	} /. {EI -> L, k -> 1} // Simplify
eqalpha // MatrixForm

eqOfAlpha = Det[eqalpha] == 0  // Simplify


equation = eqOfAlpha /. { L -> 1, \[Alpha] -> x}
Reduce[equation, {x}]
f = equation[[1]]- equation[[2]]
Plot[f, {x, -20, 20}, PlotRange -> All]


solutions = Table[FindRoot[f == 0, {x, n}], {n, 0, 20}]

CleanedSolutions = x /. solutions

verification = Table[f /. solutions[[n]], {n, Length[solutions]}]


wsol[a_] := (Function[x, Sin[a x] - Sin[a]/Sinh[a] Sinh[a x]])


aSol = {3.2732860542229476, 6.355985369201276, 9.474862047955291}
W1= wsol[aSol[[1]]]
W2= wsol[aSol[[2]]]
W3= wsol[aSol[[3]]]


MWW1 = Integrate[W1[x] W1[x], {x, 0, 1}]
MWW2 = Integrate[W2[x] W2[x], {x, 0, 1}]
MWW3 = Integrate[W3[x] W3[x], {x, 0, 1}]


c1 = 1 / Sqrt[MWW1]
c2 = 1 / Sqrt[MWW2]
c3 = 1 / Sqrt[MWW3]


calcOmega2[a_] := (a/L)^4 EI / m
eta1 = Subscript[F, 0] (c1 W1[1/2])/calcOmega2[aSol[[1]]]
eta2 = Subscript[F, 0] (c2 W2[1/2])/calcOmega2[aSol[[2]]]
eta3 = Subscript[F, 0] (c3 W3[1/2])/calcOmega2[aSol[[3]]]



