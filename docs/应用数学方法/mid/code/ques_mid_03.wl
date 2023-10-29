(* ::Package:: *)

$Assumptions = {r > 0, x >= 0};
f = x Exp[r(1-x)]
dotf = D[f, x] // Simplify


xmaxSol = Solve[dotf == 0]
xmax = xmaxSol[[1, 1, 2, 1]]


fmax = f /. x -> xmax
