(* ::Package:: *)

{u1, u2} = Map[Subscript["u", #1]&, {1, 2}]
$Assumptions = {Element[u1, Reals], Element[u2, Reals] }
u = {
  2u1 - 5u2 - 7u1^2,
  3u1 - 6u2 - 9u2^2
};
u // MatrixForm
du = D[u, {{u1, u2}}];
du // MatrixForm
jac = du /. {u1 -> 1, u2 -> -1} 
jac // MatrixForm


Det[jac]
