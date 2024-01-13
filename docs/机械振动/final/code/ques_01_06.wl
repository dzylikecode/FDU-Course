(* ::Package:: *)

M = {
  {m,  0,  0}, 
  { 0, 2m,  0},
  { 0,  0, m L^2}
  };
K = {
  {2k, -k,  0},
  {-k, k, 0},
  { 0, 0, m g L}
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


uSimpleSol = Map[(#[[1, 2, 1]])&, uSol] // Simplify

(*just for cheat, @_@*)
lambdaSimpleSolN = {lambdaSimpleSolN[[2]], lambdaSimpleSolN[[3]], lambdaSimpleSolN[[1]]}; (*swap 1 and 2*)
uSimpleSol = {uSimpleSol[[2]], uSimpleSol[[3]], uSimpleSol[[1]]}; (*swap 1 and 2, reverse 3*)
(*end*)

uSimpleSol // MatrixForm

uSimpleSol[[3]] . uSimpleSol[[3]]

uSimpleSol[[1]] . uSimpleSol[[2]]


{c1, c2, c3} = Table[Subscript[c, i], {i, 1, 3}]

U = Transpose[uSimpleSol];
U // MatrixForm
UT = Transpose[U];
UT // MatrixForm

UT . U // Simplify // MatrixForm


uSimpleSol = {c1 uSimpleSol[[1]], c2 uSimpleSol[[2]], c3 uSimpleSol[[3]]}

U = Transpose[uSimpleSol];
U // MatrixForm
UT = Transpose[U];
UT // MatrixForm

UT . M . U // Simplify// MatrixForm
UT . K . U// Simplify// MatrixForm



NormM = UT . M . U // Simplify
NormK = UT . K . U // Simplify

equations = Flatten[
  Table[NormM[[i, j]] == If[i == j, 1, 0], {i, 1, 3}, {j, 1, 3}]
]

solCs = Solve[equations, {c1, c2, c3}];

solCs



solC = solCs[[8]]

Utrue = U /. solC // Simplify
Utrue // MatrixForm

UTtrue = Transpose[Utrue];

UTtrue . M . Utrue // Simplify// MatrixForm

Lambda = UTtrue . K . Utrue // Simplify
Lambda // MatrixForm

Lambda = NormK /. solC // Simplify
Lambda // MatrixForm


expr = (2 (17 + 4 Sqrt[17]) k) / (17 m + 3 Sqrt[17] m);
conjugate = (17 m - 3 Sqrt[17] m);
rationalizedExpr = Simplify[expr * conjugate / conjugate] 

d = 2 (17 + 4 Sqrt[17]) k conjugate // Simplify
n = (17 m + 3 Sqrt[17] m) conjugate // Simplify
d / n // Simplify


d = (29+7 Sqrt[17])
n = (13+3 Sqrt[17])
nconj = (13-3 Sqrt[17])
n = n nconj // Simplify
d = d nconj // Simplify
d / n //Simplify

(*\:7ed3\:679c\:662f\:4e00\:6837\:7684, \:8d85\:51fa\:4e86mathematica\:7684\:5316\:7b80\:80fd\:529b*)



