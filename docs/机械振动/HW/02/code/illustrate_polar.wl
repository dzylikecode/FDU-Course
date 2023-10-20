(* ::Package:: *)

theta = \[Theta][t]
p = FromPolarCoordinates[{L, theta}]
a = D[p, {t, 2}]


(* ::Text:: *)
(*(-Cos[\[Theta][t]] Derivative[1][\[Theta]][t]^2, -Sin[\[Theta][t]] Derivative[1][\[Theta]][t]^2) +  (-Sin[\[Theta][t]] (\[Theta]^\[Prime]\[Prime])[t], Cos[\[Theta][t]] (\[Theta]^\[Prime]\[Prime])[t]) = a_T + a_//*)



