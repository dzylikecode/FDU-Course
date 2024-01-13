(* ::Package:: *)

ClearAll["Global`*"]
alpha= \[Alpha];
$Assumptions = {A > 0, B > 0, C > 0, D > 0, alpha > 0, EI > 0, M > 0, k > 0, L > 0 };

W = A Cos[alpha x] + B Sin[alpha x] + C Cosh[alpha x] + D Sinh[alpha x]


dW = D[W, {x}]
ddW = D[W, {x, 2}]
dddW = D[W, {x, 3}]


omega = \[Omega];
littleW = W Exp[I omega t]

ppWx = D[littleW, {x, 2}]

ppWt = D[littleW, {t, 2}]

eq1 = (EI ddW /. x -> 0) == 0 // Simplify
eq2 = (EI dddW /. x -> 0) == omega^2 (M W /. x-> 0) // Simplify


eq3 = (W /. x -> L) == 0 // Simplify
eq4 = (EI ddW /. x -> L) == - (k dW /. x-> L) // Simplify


subs = {k -> EI/L, M -> 2mL}
eq = {eq1, eq2, eq3, eq4}

EI alpha^3 / M omega^2 /. subs

eq /. subs // Simplify

eq31 = eq3 /. {C -> A, D -> B} // Simplify
eq41 = eq4 /. {C -> A, D -> B} // Simplify

eqalpha = { {4 alpha L, 1, - 1},
			{Cos[alpha L] + Cosh[alpha L], Sin[alpha L] ,  Sinh[alpha L]},
			{- EI alpha Cos[L alpha] - k Sin[L alpha] + EI alpha Cosh[L alpha] + k Sinh[L alpha], -EI alpha Sin[L alpha]+k Cos[L alpha],  EI alpha Sinh[L alpha] + k Cosh[L alpha]}
	} /. {EI -> L, k -> 1} // Simplify
eqalpha // MatrixForm

eqOfAlpha = Det[eqalpha] == 0 /. {EI -> L, k -> 1} // Simplify



equation = eqOfAlpha /. { L -> 1, \[Alpha] -> x}
Reduce[equation, {x}]
f = 1+Cosh[x] (Cos[x]-3 x Sin[x])-x (-3 Cos[x]+4 x Sin[x]) Sinh[x]
Plot[f, {x, -20, 20}, PlotRange -> All]


solutions = Table[FindRoot[f == 0, {x, n}], {n, 0, 20}]

CleanedSolutions = x /. solutions

verification = Table[f /. solutions[[n]], {n, Length[solutions]}]


coffA = {{4 x, 1, - 1}, {Cos[x] + Cosh[x], Sin[x] ,  Sinh[x]}}
varX = Transpose[{{1, B, D}}]
solX = coffA . varX == 0
solN = solX /. {x -> 0.7551906112323536}
NSolve[solN, {B, D}]


solN = solX /. {x -> 3.3393152127463277}
NSolve[solN, {B, D}]


solN = solX /. {x -> 6.393226212283557}
NSolve[solN, {B, D}]



W1[x_] := Cos[0.755191 x] - 2.9921 Sin[0.755191 x] + Cosh[0.755191 x] + 0.0286592 Sinh[0.755191 x]
W2[x_] := Cos[3.33932 x] - 14.4923 Sin[3.33932 x] + Cosh[3.33932 x] - 1.13505 Sinh[3.33932 x]
W3[x_] := Cos[6.39323 x] - 26.5665 Sin[6.39323 x] + Cosh[6.39323 x] - 0.99357 Sinh[6.39323 x]


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


