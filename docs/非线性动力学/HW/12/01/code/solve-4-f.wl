(* ::Package:: *)

J = {
{-2, 3},
{2, -3}
}
Eigensystem[J]


(* Define the parabolic equation and line equations *)
parabola = Plot[{-Sqrt[-3/35*x], Sqrt[-3/35*x]}, {x, -16, 0}, PlotStyle -> {{Dashed, Black}, {Dashed, Black}},  AxesOrigin -> {0, 0}, AxesStyle -> Black];
dashedLine = Plot[0, {x, -16, 0}, PlotStyle -> {Thick, Black}, AxesOrigin -> {0, 0}, AxesStyle -> Black];
solidLine = Plot[0, {x, 0, 16}, PlotStyle -> {Dashed, Black}, AxesOrigin -> {0, 0}, AxesStyle -> Black];

(* Combine all plots *)
fig = Show[parabola, dashedLine, solidLine, PlotRange -> {{-1, 1}, {-1, 1}}, Axes -> {True, True}, Frame -> True, FrameStyle -> Black, AxesLabel -> {"\[CurlyEpsilon]", "u"}]

fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName];
SetName[n_] := ToString[StringForm["../figure/``.png", n]];

Export[SetName["4-f-depend"], fig];
