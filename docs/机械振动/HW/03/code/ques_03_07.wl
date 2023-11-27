(* ::Package:: *)

k1 = Subscript[k, 1]; k2 = Subscript[k, 2]; k3 = Subscript[k, 3];
A = {
  {  k1,    - k1,       0,    0},
  {- k1, k1 + k2,    - k2,    0},
  {   0,    - k2, k2 + k3, - k3},
  {   0,       0,    - k3,   k3}
};
A // MatrixForm
NullSpace[A]


A = {
  {1, -1,  0,  0},
  {0,  1, -1,  0},
  {0,  0,  1, -1}
};
A // MatrixForm
PseudoInverse[A] // MatrixForm


M = {
  {m, 0, 0}, 
  {0, m, 0},
  {0, 0, m}
  };
K = {
  {2k, -k,  0},
  {-k, 2k, -k},
  { 0, -k, 2k}
  };
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

(*just for cheat, @_@*)
lambdaSimpleSolN = {lambdaSimpleSolN[[2]], lambdaSimpleSolN[[1]], lambdaSimpleSolN[[3]]}; (*swap 1 and 2*)
uSimpleSol = {uSimpleSol[[2]], uSimpleSol[[1]], - uSimpleSol[[3]]}; (*swap 1 and 2, reverse 3*)
(*end*)

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



