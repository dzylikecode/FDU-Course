(* ::Package:: *)

f = Sign[- omega0 a Sin[psi]]

D1a = N / (2 Pi omega0) Integrate[f Sin[psi], {psi, 0, 2 Pi}]


D1phi = N / (2 Pi omega0 a) Integrate[f Cos[psi], {psi, 0, 2 Pi}]
