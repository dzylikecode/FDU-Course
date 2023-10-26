(* ::Package:: *)

fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName]
SetName[n_] := ToString[StringForm["../figure/``_``.png", fileBaseName, n]];

w = \[Omega];
a = \[Alpha];
fs = Subscript[f, s];
$Assumptions = {a > 0, a < 1, w > 0};

H = a + (1-a) Cos[w];
Habs = Abs[H]
area = Integrate[Habs, {w, -Pi, Pi}]


fig = Plot[area, {\[Alpha], 0, 1}, PlotRange->{{0, 1}, {0, 8}}, AxesLabel->{a, "Area"}]
Export[SetName["1"], fig];


dArea = D[area, \[Alpha]]


Solve[dArea == 0, \[Alpha]]


FindMinimum[area, {\[Alpha], 0.25}]
