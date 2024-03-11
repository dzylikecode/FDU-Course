(* ::Package:: *)

lambda = \[Lambda]


eqs = {
m ddx1 ==   m g sinTheta + lambda,
m ddx2 ==   m g  + 2 lambda,
m ddx3 ==   m g sinPhi + lambda,
ddx1 + 2 ddx2 + ddx3 == 0
}


Solve[eqs, {ddx1, ddx2, ddx3, lambda}] // Simplify
