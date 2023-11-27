(* ::Package:: *)

L1 = Subscript[L, 1];
theta1 = Subscript[\[Theta], 1][t];

L2 = Subscript[L, 2];
theta2 = Subscript[\[Theta], 2][t];

L3 = Subscript[L, 3];
theta3 = Subscript[\[Theta], 3][t];

m1 = Subscript[m, 1];
m2 = Subscript[m, 2];
m3 = Subscript[m, 3];

OA = FromPolarCoordinates[{L1, theta1}]

AB = FromPolarCoordinates[{L2, theta2}]

BC = FromPolarCoordinates[{L3, theta3}]

OB = OA + AB
OC = OB + BC

r1 = OA;
v1 = D[r1, t];
r2 = OB;
v2 = D[r2, t]
r3 = OC;
v3 = D[r3, t]


T = 1/2 m1 v1 . v1 + 1/2 m2 v2 . v2 + 1/2 m3 v3 . v3
T // Simplify


V = m1 g (L1 - r1[[1]]) + m2 g (L1 + L2 - r2[[1]]) + m3 g (L1 + L2 + L3 - r3[[1]])


Lg = T - V
Needs["VariationalMethods`"]
EqEular = VariationalMethods`EulerEquations[Lg, {theta1, theta2, theta3}, t]
EqEular // Simplify


M = {{4, 3, 2}, {3, 3, 2}, {2, 2, 2}};
K = {{4, 0, 0}, {0, 3, 0}, {0, 0, 2}};
M // MatrixForm
K // MatrixForm


lambda = \[Lambda];
A = K - lambda M;
A // MatrixForm


eq = Det[A]


lambdaSol = Solve[eq == 0, lambda]
lambdaSolN = lambdaSol // N
lambdaSimpleSolN = Map[#[[1, 2]]&, lambdaSolN]
omega = \[Omega]


omegaSol = Map[{omega -> Sqrt[#[[1, 2]]]}&, lambdaSol]
omegaSol // N


uSol = Map[{u -> NullSpace[K - #[[1, 2]] M]}&, lambdaSol]
Map[{u -> (#[[1, 2]] // N // MatrixForm)}&, uSol]


uSimpleSol = Map[(#[[1, 2, 1]] // N // Normalize)&, uSol]

Draw[d_, t_] := ListPlot[d, Joined -> True, PlotLabel -> t];
ToPoints[d_] := Table[{i, (d[[i]])}, {i, 1, Length[d]}];
title[i_] := ToExpression[ToString[StringForm["u_``=``\\sqrt{\\frac{g}{L}}", i, lambdaSimpleSolN[[i]]]], TeXForm];

figs = MapIndexed[(Draw[ToPoints[#1], title[First[#2]]])&, uSimpleSol]

fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName];
SetName[n_] := ToString[StringForm["../figure/``_``.png", fileBaseName, n]];

MapIndexed[Export[SetName[First[#2]],#1]&, figs];



