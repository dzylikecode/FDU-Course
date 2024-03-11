(* ::Package:: *)

{m1, m2} = Table[Subscript[m, i], {i, 1, 2}]
{lambda1, lambda2} = Table[Subscript[\[Lambda], i], {i, 1, 2}]


eqs = {
m1 ddx1 == lambda1 tanTheta,
m1 ddy1 == - m1 g + lambda1,
m2 ddx2 == - lambda1 tanTheta,
m2 ddy2 == - m2 g - lambda1 + lambda2,
(ddx1 - ddx2) tanTheta + (ddy1 - ddy2) == 0,
ddy2 == 0
}


Solve[eqs, {ddx1, ddx2, ddy1, ddy2, lambda1, lambda2}] // Simplify
