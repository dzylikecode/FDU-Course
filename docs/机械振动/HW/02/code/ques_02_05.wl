(* ::Package:: *)

ClearAll["Global`*"]
k1 = Subscript[K, 1];
k2 = Subscript[K, 2];
Px = x[t];
Py = y[t];
P = {Px, Py};
$Assumptions = {a > 0, k1 > 0, k2 > 0, Px \[Element] Reals, Py \[Element] Reals, m > 0};
dist[u_, v_] := EuclideanDistance[u, v]//Simplify;


v = D[P, t]
Tg = 1/2 m v . v


spring = {{k1, {-a, 0}}, {k1, {a, 0}}, {k2, {0, a}}, {k2, {0, -a}}}
fDx[p_] := dist[p, P] - dist[p, {0, 0}];
fkEnergy[k_] := 1/2 k[[1]] fDx[k[[2]]]^2;
Vg = Map[fkEnergy, spring] // Total


Lg = Tg - Vg
Needs["VariationalMethods`"]
EqEular = VariationalMethods`EulerEquations[Lg, {Px, Py}, t]
EqEular // Simplify


(* ::Text:: *)
(*[calculus and analysis - How to calculate the total differential at a point? - Mathematica Stack Exchange](https://mathematica.stackexchange.com/questions/263921/how-to-calculate-the-total-differential-at-a-point)*)


Clear[{x, y}]
$Assumptions = {a > 0, x \[Element] Reals, y > 0};
s = Dt[dist[{x, y}, {a, 0}], Constants->a] // Simplify
s /. {Dt[x, _] -> d1, Dt[y, _] -> d2} /. {x -> 0, y -> 0} /. { 
  d1 -> Dt[x], d2 -> Dt[y]} // Simplify


