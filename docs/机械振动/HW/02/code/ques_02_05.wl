(* ::Package:: *)

k1 = Subscript[K, 1];
k2 = Subscript[K, 2];
Px = x[t];
Py = y[t];
P = {Px, Py};
$Assumptions = {a > 0, k1 > 0, k2 > 0, Px \[Element] Reals, Py \[Element] Reals, m > 0};
dist[u_, v_] := EuclideanDistance[u, v]// Simplify;


v = D[P, t]
Tg = 1/2 m v . v


spring = {{k1, {-a, 0}}, {k1, {a, 0}}, {k2, {0, a}}, {k2, {0, -a}}}
fDx[p_] := dist[p, P] - dist[p, {0, 0}];
fkEnergy[k_] := 1/2 k[[1]] fDx[k[[2]]]^2;
Vg = Map[fkEnergy, spring] // Total // Simplify


Lg = Tg - Vg
Needs["VariationalMethods`"]
EqEular = VariationalMethods`EulerEquations[Lg, {Px, Py}, t]
EqEular // Simplify



