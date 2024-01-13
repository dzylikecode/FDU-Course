(* ::Package:: *)

n1 = 65 m-7 Sqrt[65] m;
nConj1 = 65 m+7 Sqrt[65] m;
nNew1 = n1 nConj1 // Simplify
d1 = 2;
dNew1 = d1 nConj1 // Simplify
c1 = dNew1 / nNew1 // Simplify


n2 = 65 m+7 Sqrt[65] m;
nConj2 = 65 m-7 Sqrt[65] m;
nNew2 = n2 nConj2 // Simplify
d2 = 2;
dNew2 = d2 nConj2 // Simplify
c2 = dNew2 / nNew2 // Simplify


c3 = 1/(Sqrt[2] L Sqrt[m])
