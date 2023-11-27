(* ::Package:: *)

L1 = Subscript[L, 1];
L2 = Subscript[L, 2];
theta1 = Subscript[\[Theta], 1][t];
theta2 = Subscript[\[Theta], 2][t];
$Assumptions = {m > 0, L1 > 0, L2 > 0, theta1 > 0, theta2 > 0, g > 0, L > 0};


OA  = FromPolarCoordinates[{L1, theta1}];
AB  = FromPolarCoordinates[{L2, theta2}];
OB  = OA + AB;
rO2 = OA + 1/2 AB;
vO2 = D[rO2, t];
J   = 1/3 m (L2/2)^2;


T = 1/2 m vO2 . vO2 + 1/2 J D[theta2, t]^2 // Simplify


V = m g (L1 + L2 - rO2[[1]])


Lg = T - V;
Needs["VariationalMethods`"];
EqEular = VariationalMethods`EulerEquations[Lg, {theta1, theta2}, t];
EqEular // Simplify


EqEular /. {Sin[x_] -> x, Cos[x_] -> 1} // Simplify


M = {{m L1^2, m/2 L1 L2}, {m/2 L1 L2, m/3 L2^2}} /. {L1 -> L, L2 -> L};
K = {{m g L1, 0}, {0, m/2 g L2}} /. {L1 -> L, L2 -> L};
M // MatrixForm
K // MatrixForm


lambda = \[Lambda];
A = K - lambda M;
A // MatrixForm


eq = Det[A]


lambdaSol = Solve[eq == 0, lambda]
lambdaSolN = lambdaSol 
lambdaSimpleSolN = Map[#[[1, 2]]&, lambdaSolN]
omega = \[Omega]


omegaSol = Map[{omega -> Sqrt[#[[1, 2]]]}&, lambdaSol]
omegaSol // N


uSol = Map[{u -> NullSpace[K - #[[1, 2]] M]}&, lambdaSol]
Map[{u -> (#[[1, 2]] // N // MatrixForm)}&, uSol]


uSimpleSol = Map[(#[[1, 2, 1]] // Normalize)&, uSol] // Simplify

Draw[d_, t_] := ListPlot[d, Joined -> True, PlotLabel -> t];
ToPoints[d_] := Table[{i, (d[[i]] /. L -> 1)}, {i, 1, Length[d]}];
title[i_] := ToExpression[ToString[StringForm["u_``=``", i, ToString[lambdaSimpleSolN[[i]] // TeXForm]]], TeXForm];

figs = MapIndexed[(Draw[ToPoints[#1], title[First[#2]]])&, uSimpleSol]

fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName];
SetName[n_] := ToString[StringForm["../figure/``_``.png", fileBaseName, n]];

MapIndexed[Export[SetName[First[#2]],#1]&, figs];





