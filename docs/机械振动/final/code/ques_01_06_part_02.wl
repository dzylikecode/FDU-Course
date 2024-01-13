(* ::Package:: *)

n1 = 17 m-3 Sqrt[17] m;
nConj1 = 17 m+3 Sqrt[17] m;
nNew1 = n1 nConj1 // Simplify
d1 = 2;
dNew1 = d1 nConj1 // Simplify
c1 = dNew1 / nNew1 // Simplify


n2 = 17 m+3 Sqrt[17] m;
nConj2 = 17 m-3 Sqrt[17] m;
nNew2 = n2 nConj2 // Simplify
d2 = 2;
dNew2 = d2 nConj2 // Simplify
c2 = dNew2 / nNew2 // Simplify


c3 = 1/(L Sqrt[m])
