(* ::Package:: *)

F0 = Subscript[F, 0];
$Assumptions = {m > 0, L > 0, k > 0, F0 > 0};

M = {
  {m,  0,  0}, 
  { 0, 4 m,  0},
  { 0,  0, 2 m L^2}
  };
K = {
  {2k, -k,  0},
  {-k, k, 0},
  { 0, 0, 2 m g L}
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


n1 = 65 m-7 Sqrt[65] m;
nConj1 = 65 m+7 Sqrt[65] m;
nNew1 = n1 nConj1 // Simplify
d1 = 2;
dNew1 = d1 nConj1 // Simplify
c1 = Sqrt[dNew1 / nNew1 // Simplify]


n2 = 65 m+7 Sqrt[65] m;
nConj2 = 65 m-7 Sqrt[65] m;
nNew2 = n2 nConj2 // Simplify
d2 = 2;
dNew2 = d2 nConj2 // Simplify
c2 = Sqrt[dNew2 / nNew2 // Simplify]

c3 = 1/(Sqrt[2] L Sqrt[m])


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


theta = \[Theta]
Fori = Transpose[{{0, F0 Cos[Sqrt[2] t] Sin[theta], F0 L Cos[Sqrt[2] t]}}]
Ftra = UTreal . Fori // Simplify

Sqrt[298+406/Sqrt[65]]/(20 Sqrt[m]) // N

coeff = Ftra / lambdaSimpleSolN // FullSimplify
eta = coeff Transpose[{Table[Subscript[g, i], {i, 1, 3}]}]
Ureal . eta // FullSimplify
2 Sqrt[309-11 Sqrt[65]]// FullSimplify


(Sqrt[794 m+(6374 m)/Sqrt[65]]/(5 k))/ 10// N


2 ((195+17 Sqrt[65]) /325) / 10 // N


((2 ((195+17 Sqrt[65]) Subscript[g, 1]+(195-17 Sqrt[65]) Subscript[g, 2]))/(325 k)) / 10 // N // Simplify


(((1235+157 Sqrt[65]) Subscript[g, 1]+(1235-157 Sqrt[65]) Subscript[g, 2])/(650 k)) / 10 // N // Simplify
