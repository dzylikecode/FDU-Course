(* ::Package:: *)

{u1, u2} = Map[Subscript["u", #1]&, {1, 2}]
$Assumptions = {Element[u1, Reals], Element[u2, Reals] }
u = {
  Tan[u2 - u1],
  2^u2 - 2 Cos[Pi/3 - u1]
}
D[u, {{u1, u2}}] // MatrixForm


(*2*)
u = {
  Log[Exp[-3 u1] + 4 u2],
  (1-6u1)^(1/3) + 2u2 - 1
}
D[u, {{u1, u2}}] // MatrixForm



