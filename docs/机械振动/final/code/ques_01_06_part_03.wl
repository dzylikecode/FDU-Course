(* ::Package:: *)

$Assumptions = {m > 0, L > 0, k > 0};

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
omegaSol = {omegaSol[[2]], omegaSol[[3]], omegaSol[[1]]}; (*swap 1 and 2, reverse 3*)
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


n1 = 17 m-3 Sqrt[17] m;
nConj1 = 17 m+3 Sqrt[17] m;
nNew1 = n1 nConj1 // Simplify
d1 = 2;
dNew1 = d1 nConj1 // Simplify
c1 = Sqrt[dNew1 / nNew1 // Simplify]


n2 = 17 m+3 Sqrt[17] m;
nConj2 = 17 m-3 Sqrt[17] m;
nNew2 = n2 nConj2 // Simplify
d2 = 2;
dNew2 = d2 nConj2 // Simplify
c2 = Sqrt[dNew2 / nNew2 // Simplify]

c3 = 1/(L Sqrt[m])


SolC = {Subscript[c, 1] -> c1, Subscript[c, 2] -> c2, Subscript[c, 3] -> c3}
NormM
NormK
NormM /. SolC // Simplify // MatrixForm
NormK /. SolC // Simplify // MatrixForm

Ureal = U /. SolC // Simplify
Ureal // MatrixForm
UTreal = UT /. SolC // Simplify
Uinv = UTreal . M // Simplify
Uinv // Simplify
Uinv . Ureal // Simplify // MatrixForm


omega1 = omegaSol[[1, 1, 2]]
omega2 = omegaSol[[2, 1, 2]]
omega3 = omegaSol[[3, 1, 2]]
omegaSol = Transpose[{{omega1, omega2, omega3}}]
y10 = Transpose[{{0, 1, 0}}]
doty10 = Transpose[{{0, 0, 0}}]
eta10 = Uinv . y10 // Simplify
doteta10 = Uinv . doty10 // Simplify
Ca1 = eta10
Ca2 = doteta10 / omegaSol
cosList = {Cos[omega1 t], Cos[omega2 t], Cos[omega3 t]}
sinList = {Sin[omega1 t], Sin[omega2 t], Sin[omega3 t]}


etaa = Ca1 cosList + Ca2 sinList // Simplify


ya = Ureal . etaa // FullSimplify (*\:8fd8\:6709\:8fd9\:4e2a\:6765\:5316\:7b80 26 - 6 Sqrt[17]*)
testab = (26-6 Sqrt[17])(17+3 Sqrt[17])^2 // Simplify
Sqrt[testab]
34 (13-3 Sqrt[17]) // Simplify
FullSimplify[Sqrt[26 - 6 Sqrt[17]]]


y10 = Transpose[{{1, 0, 1}}]
doty10 = Transpose[{{0, 0, 0}}]
eta10 = Uinv . y10 // Simplify
doteta10 = Uinv . doty10 // Simplify
Ca1 = eta10
Ca2 = doteta10 / omegaSol
etaa = Ca1 cosList + Ca2 sinList // Simplify
ya = Ureal . etaa // FullSimplify


y10 = Transpose[{{0, 0, 0}}]
doty10 = Transpose[{{1, 1, 0}}]
eta10 = Uinv . y10 // FullSimplify
doteta10 = Uinv . doty10 // FullSimplify
Ca1 = eta10
Ca2 = doteta10 / omegaSol
etaa = Ca1 cosList + Ca2 sinList // FullSimplify
ya = Ureal . etaa // FullSimplify

eta10 = Uinv . y10 // Simplify
doteta10 = Uinv . doty10 // Simplify
Ca1 = eta10
Ca2 = doteta10 / omegaSol
etaa = Ca1 cosList + Ca2 sinList // Simplify


8/(2 Sqrt[17 (95+23 Sqrt[17])]) // FullSimplify


d = 4
n = (95+23 Sqrt[17])(95-23 Sqrt[17]) // Simplify


(4Sqrt[(95-23 Sqrt[17])])/Sqrt[17 32]// Simplify
