(* ::Package:: *)

ClearAll["Global`*"]
alpha= \[Alpha];
$Assumptions = {A \[Element] Reals, B \[Element] Reals, C \[Element] Reals, D \[Element] Reals, alpha > 0, EI > 0, M > 0, k > 0, L > 0 };

W = A Sin[alpha x] + B Cos[alpha x]


dW = D[W, {x}]
ddW = D[W, {x, 2}]
dddW = D[W, {x, 3}]


omega = \[Omega];
littleW = W Exp[I omega t]

ppWx = D[littleW, {x, 2}]

ppWt = D[littleW, {t, 2}]

eq1 = (W /. x -> 0) == 0 // Simplify
eq2 = (T dW + k W/. x -> L) == 0 // Simplify


eq = {eq1, eq2} /. {k -> k} // Simplify

eq // Simplify

eq21 = eq[[2]] /. {B -> 0} // Simplify

eqalpha = T \[Alpha] Cos[L \[Alpha]]+k Sin[L \[Alpha]]// Simplify

eqOfAlpha = eqalpha == 0  // Simplify


equation = eqOfAlpha /. {k -> 1, T -> L} /. { L -> 1, \[Alpha] -> x}
Reduce[equation, {x}]
f = equation[[1]]- equation[[2]]
Plot[f, {x, -20, 20}, PlotRange -> All]


solutions = Table[FindRoot[f == 0, {x, n}], {n, 0, 20}]

CleanedSolutions = x /. solutions

verification = Table[f /. solutions[[n]], {n, Length[solutions]}]


wsol[a_] := (Function[x, Sin[a x]])


W1= wsol[2.0287578381104345]
W2= wsol[4.913180439434884]
W3= wsol[7.978665712413241]


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



