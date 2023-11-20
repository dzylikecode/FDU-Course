(* ::Package:: *)

Cbtw = (10^(Subscript[a, p]/10) - 1)^(1/2)
Nbtw = 1/2 Log[Subscript[\[Lambda], s], (10^(Subscript[a, s]/10) - 1)/(10^(Subscript[a, p]/10) - 1)]


Cbtw /. Subscript[a, p] -> 3 // N


lambdaS = 200/100;
Nbtw /. Subscript[a, p] -> 3 /. Subscript[a, s] -> 10 /. Subscript[\[Lambda], s] -> lambdaS // N


Hs = (p - Subscript[p, 1])(p - Subscript[p, 2]) /. Subscript[p, 1] -> Exp[I 3/4 Pi] /. Subscript[p, 2] -> Exp[I 5/4 Pi] // Simplify


Hw = Hs /. p -> I w/(200 Pi)


Hz = Hs /. p -> 2 * 1000 ((z - 1)/(z + 1)) / (200 Pi)
Hn = Hz * (z+1)^2 // Simplify // Expand
an = Coefficient[Hn, z, Exponent[Hn, z]]
an // N
Hn / an // N // Simplify



