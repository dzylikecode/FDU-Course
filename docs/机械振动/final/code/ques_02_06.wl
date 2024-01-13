(* ::Package:: *)

ClearAll["Global`*"]
alpha= \[Alpha];
$Assumptions = {A > 0, B > 0, C > 0, D > 0, alpha > 0, EI > 0, M > 0, k > 0, L > 0, x>=0 };

W = A Cos[alpha x] + B Sin[alpha x] + C Cosh[alpha x] + D Sinh[alpha x]

W1[x_] := Cos[0.755191 x] - 2.9921 Sin[0.755191 x] + Cosh[0.755191 x] + 0.0286592 Sinh[0.755191 x]
W2[x_] := Cos[3.33932 x] - 14.4923 Sin[3.33932 x] + Cosh[3.33932 x] - 1.13505 Sinh[3.33932 x]
W3[x_] := Cos[6.39323 x] - 26.5665 Sin[6.39323 x] + Cosh[6.39323 x] - 0.99357 Sinh[6.39323 x]



intW[f_] := Integrate[f[x] f[x], {x, 0, 1}] + 2 f[0] f[0]
calcC[f_] := Sqrt[1/intW[f]]
c1 = calcC[W1]
c2 = calcC[W2]
c3 = calcC[W3]


wx0[x_] := 2 Sin[Pi x] - x + x^2
dotwx0[x_] := 0


calcEta[w_] := Integrate[w wx0[x], {x, 0, 1}]
c1 W1[x]
eta1 = calcEta[c1 W1[x]] // N
eta2 = calcEta[c2 W2[x]] // N
eta3 = calcEta[c1 W3[x]] // N


alphaList = {0.755191, 3.33932, 6.39323}
alphaList ^ 2


omegaSquare = alphaList^4
calcCoff[w_, omega_] := w[3/4]/omega
calcCoff[W1, omegaSquare[[1]]]
calcCoff[W2, omegaSquare[[2]]]
calcCoff[W3, omegaSquare[[3]]]



