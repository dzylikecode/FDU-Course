(* ::Package:: *)

sol = Integrate[1/6 a^3 Cos [omega t]^4, {t, 0, 2 Pi}]


sol /. {omega -> 1} 
