(* ::Package:: *)

Q = 2 x^2 - 1


Q2 = Q /. x -> Q // Simplify


sol = Solve[Q2 == x]


dotQ2 = D[Q2, x]


x1 = sol[[3, 1, 2]]
x2 = sol[[4, 1, 2]]


dotQ2 /. x -> x1 // Simplify
dotQ2 /. x -> x2 // Simplify



