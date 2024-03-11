(* ::Package:: *)

{mC, mAB} = {Subscript[m, C], Subscript[m, AB]}
{lambda1, lambda2, lambda3} = Table[Subscript[\[Lambda], i], {i, 1, 3}]


eqs = {
mC ddxC == lambda3,
mC ddyC == mC g + lambda2,
1/2 mC R^2 ddPhi == - R lambda3,
mAB ddxAB == F - lambda3,
mAB ddyAB == mAB g + lambda1 - lambda2,
ddyAB == 0,
ddyC - ddyAB == 0,
ddxC - ddxAB - R ddPhi == 0
}


Solve[eqs, {ddxC, ddyC, ddPhi, ddxAB, ddyAB, lambda1, lambda2, lambda3}] // Simplify
