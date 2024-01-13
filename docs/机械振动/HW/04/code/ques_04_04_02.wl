(* ::Package:: *)

ClearAll["Global`*"]
alpha= \[Alpha];
$Assumptions = {A \[Element] Reals, B \[Element] Reals, C \[Element] Reals, D \[Element] Reals, alpha > 0, EI > 0, M > 0, k > 0, L > 0 };

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


wsol[a_] := (Function[x, Sin[a x] + Sin[a]/Sinh[a] Sinh[a x]])


W1= wsol[3.926602312047919]
W2= wsol[7.068582745628732]
W3= wsol[10.210176122813031]


fig1 = Plot[W1[x], {x, 0, 1}, PlotLabel -> "W1(x)", PlotRange -> All, PlotTheme -> "Detailed"]
fig2 = Plot[W2[x], {x, 0, 1}, PlotLabel -> "W2(x)", PlotRange -> All, PlotTheme -> "Detailed"]
fig3 = Plot[W3[x], {x, 0, 1}, PlotLabel -> "W3(x)", PlotRange -> All, PlotTheme -> "Detailed"]

figs = {fig1, fig2, fig3}

fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName];
SetName[n_] := ToString[StringForm["../figure/``_``.png", fileBaseName, n]];

MapIndexed[Export[SetName[First[#2]],#1]&, figs];




