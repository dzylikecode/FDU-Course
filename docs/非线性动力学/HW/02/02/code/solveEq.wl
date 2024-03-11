(* ::Package:: *)

{lambda1, lambda2} = Table[Subscript[\[Lambda], i], {i, 1, 2}]


eqs = {
  m ddy1 ==   m g + lambda1 -  2 lambda2,
6 m ddy2 == 6 m g + lambda1,
2 m ddy3 == 2 m g + lambda2,
3 m ddy4 == 3 m g + lambda2,
ddy2 + ddy1 == 0,
ddy3 + ddy4 - 2 ddy1 == 0
}


Solve[eqs, {ddy1, ddy2, ddy3, ddy4, lambda1, lambda2}] // Simplify
