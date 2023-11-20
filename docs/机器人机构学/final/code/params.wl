(* ::Package:: *)

angleGroup = {40, 80};
angles = Table[i* 120 + angleGroup, {i, 0, 2}] // Flatten
radius = angles/180 Pi
pos = Map[FromPolarCoordinates[{1, If[# > Pi, #- 2 Pi, #]}]&, radius] // N
tupleString[x_, y_] := StringJoin[ToString[x], ", ", ToString[y]]
matlabArray = StringJoin["[", StringJoin[Riffle[tupleString[#[[1]], #[[2]]] & /@ pos, "; "]], "]"]
pos // MatrixForm



