(* ::Package:: *)

{m1, m2, m3} = Table[Subscript[m, i], {i, 1, 3}]
{k1, k2, k3} = Table[Subscript[k, i], {i, 1, 3}]
{F1, F2, F3} = Table[Subscript[F, i], {i, 1, 3}]
sinTheta = F3/(m3 g)


eq1 = (k1 + k2) u1 - k2 u2 + m1 g == F1
eq2 = -k2 u1 + k2 u2 + (m2 + m3)g == F2 + F3 sinTheta


sol = Solve[{eq1, eq2}, {u1, u2}] // Simplify


sol /. {F1 -> 0, F2 -> 0, F3 -> 0} // Simplify
