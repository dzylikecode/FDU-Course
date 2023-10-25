(* ::Package:: *)

T = Pi
omega = (2 Pi)/T
f = Sin[t] Exp[-I k omega t]
res = 1/T Integrate[f, {t, 0, T}]
Simplify[res, Assumptions -> k \[Element] Integers]



