(* ::Package:: *)

fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName]
SetName[n_] := ToString[StringForm["../figure/``_``.png", fileBaseName, n]];
fs = 1000;
H = 1/7 + 2/7 Cos[w/fs] + 2/7 Cos[(2 w)/fs] + 2/7 Cos[(3 w)/fs] 
Hf = H /. {w -> 2 Pi f}
Hfabs = Abs[Hf];


fig02 = Plot[Hfabs, {f, - (fs/2), fs/2}]
Export[SetName["1"], fig02];


Hfabs /. f -> 200 // N
