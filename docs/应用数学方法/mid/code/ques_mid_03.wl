(* ::Package:: *)

$Assumptions = {r > 0, x >= 0};
f = x Exp[r(1-x)]
dotf = D[f, x] // Simplify


xmaxSol = Solve[dotf == 0]
xmax = xmaxSol[[1, 1, 2, 1]]


fmax = f /. x -> xmax


g = f + x
dotg = D[g, x] // Simplify
ddotg = D[dotg, x] // Simplify
ddotg2 = ddotg /. r -> 2 // Simplify



