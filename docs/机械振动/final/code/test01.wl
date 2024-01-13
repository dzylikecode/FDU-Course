(* ::Package:: *)

(* \:5b9a\:4e49\:7b26\:53f7\:53d8\:91cf *)
a = Symbol["a"];
b = Symbol["b"];
c = Symbol["c"];
d = Symbol["d"];
al = Symbol["al"];

(* \:5b9a\:4e49\:77e9\:9635 A *)
A = {
  {0, -1, 0, 1},
  {1, 2*al, -1, 2*al},
  {Sin[al], Cos[al], Sinh[al], Cosh[al]},
  {-al*Sin[al] - Cos[al], -al*Cos[al] + Sin[al], al*Sinh[al] - Cosh[al], al*Cosh[al] - Sinh[al]}
};

(* \:8ba1\:7b97\:884c\:5217\:5f0f *)
f = Det[A];

(* \:7b80\:5316 f *)
f = Simplify[f];

f

(* \:7ed8\:5236 f \:7684\:56fe\:50cf *)
Plot[f, {al, -10, 10}]


solutions = NSolve[f == 0, al]



