(* ::Package:: *)

M = {
  {2m,  0,  0}, 
  { 0, 2m,  0},
  { 0,  0, 2m}
  };
K = {
  {3k, -k,  0},
  {-k, 2k, -k},
  { 0, -k, 3k}
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
lambdaSimpleSolN = {lambdaSimpleSolN[[1]], lambdaSimpleSolN[[2]], lambdaSimpleSolN[[3]]}; (*swap 1 and 2*)
uSimpleSol = {uSimpleSol[[1]], uSimpleSol[[2]], uSimpleSol[[3]]}; (*swap 1 and 2, reverse 3*)
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




