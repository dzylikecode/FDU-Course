(* ::Package:: *)

(* \:5b9a\:4e49\:7ed8\:5236\:76f8\:56fe\:7684\:51fd\:6570 *)
ClearAll[plotPhasePortrait]
plotPhasePortrait[
	bVal_, kVal_, 
	initialConditionsList_List, 
	tspan_List, 
	tArrow_List,
	opts : OptionsPattern[]
] := Module[
  (*\:5c40\:90e8\:53d8\:91cf*)
  {
    A, eqs, solutions, parametricPlots, arrows
  },
  
  (* \:5b9a\:4e49\:7cfb\:7edf\:77e9\:9635 *)
  A = {
    {0, 1},
    {-kVal, -bVal}
  };
  
  (* \:5b9a\:4e49\:65b9\:7a0b\:7ec4 *)
  eqs = {
    x1'[t] == A[[1, 1]]*x1[t] + A[[1, 2]]*x2[t],
    x2'[t] == A[[2, 1]]*x1[t] + A[[2, 2]]*x2[t]
  };
  
  (* \:4f7f\:7528 DSolve \:6c42\:89e3\:591a\:4e2a\:521d\:59cb\:6761\:4ef6\:7684\:65b9\:7a0b *)
  solutions = Table[
    DSolve[{eqs, initCond}, {x1[t], x2[t]}, t],
    {initCond, initialConditionsList}
  ];
  
  (* \:5355\:72ec\:7ed8\:5236\:6bcf\:6761\:8f68\:8ff9\:7684 ParametricPlot *)
  parametricPlots = Table[
    ParametricPlot[
      Evaluate[{x1[t], x2[t]} /. solutions[[i, 1]]], {t, tspan[[1]], tspan[[2]]},
      PlotStyle -> {Thick},
      PlotRange -> {{-2, 2}, {-2, 2}}
    ],
    {i, Length[solutions]}
  ];
  
  (* \:4e3a\:6bcf\:6761\:8f68\:8ff9\:751f\:6210\:7bad\:5934 *)
  arrows = Table[
    Arrow[{
      {x1[t], x2[t]} /. solutions[[i, 1]] /. t -> tArrow[[i]],
      {x1[t], x2[t]} /. solutions[[i, 1]] /. t -> tArrow[[i]] + 0.1
    }],
    {i, Length[solutions]}
  ];
  
  (* \:663e\:793a\:5305\:542b\:7bad\:5934\:7684\:6240\:6709\:8f68\:8ff9\:ff0c\:5e94\:7528\:7528\:6237\:63d0\:4f9b\:7684\:989d\:5916\:9009\:9879 *)
  Show[
    parametricPlots,
    Epilog -> arrows,
    opts
  ]
];

(* \:793a\:4f8b\:4f7f\:7528 *)
initialConditionsList = {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == -1, x2[0] == 0},
  {x1[0] == 0.5, x2[0] == 0.5},
  {x1[0] == -0.5, x2[0] == -0.5}
};

plotPhasePortrait[
  0.5, 2, 
  initialConditionsList, 
  {0, 10},
  {5, 5, 5, 5},
  AxesLabel -> {"x", "y"},
  PlotRange -> {{-3, 3}, {-3, 3}}
]



(* \:793a\:4f8b\:521d\:59cb\:6761\:4ef6\:5217\:8868 *)
initialConditions1 = {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == -1, x2[0] == 0}
};

initialConditions2 = {
  {x1[0] == 0.5, x2[0] == 0.5},
  {x1[0] == -0.5, x2[0] == -0.5}
};

(* \:4f7f\:7528\:4e0d\:540c\:53c2\:6570\:7ec4\:5408\:6765\:751f\:6210\:591a\:4e2a\:76f8\:8f68\:56fe *)
phase1 = plotPhasePortrait[0.5, 2, initialConditions1, {0, 10},
  PlotLabel -> "Phase Portrait 1",
  AxesLabel -> {"x1[t]", "x2[t]"}
];

phase2 = plotPhasePortrait[1.0, 1.5, initialConditions2, {0, 10},
  PlotLabel -> "Phase Portrait 2",
  AxesLabel -> {"x1[t]", "x2[t]"}
];

(* \:5c06\:4e24\:4e2a\:76f8\:56fe\:653e\:5728\:4e00\:5f20\:56fe\:4e2d *)
GraphicsGrid[{{phase1, phase2}}]


xyLabel = {"x", "y"};
p1 = plotPhasePortrait[
  2, 0.5, 
  {
  {x1[0] == 1, x2[0] == 1},
  {x1[0] == -1, x2[0] == -1},
  {x1[0] == 0.5, x2[0] == 1},
  {x1[0] == -0.5, x2[0] == -1}
  }, 
  {0, 20},
  {0.5, 0.5, 0.5, 0.5},
(*  PlotLabel -> "\:7a33\:5b9a\:7ed3\:70b9",*)
  AxesLabel -> xyLabel
]

p2 = plotPhasePortrait[
  -2, 1, 
  {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == -1, x2[0] == 0},
  {x1[0] == 0.5, x2[0] == 0},
  {x1[0] == -0.5, x2[0] == 0}
  }, 
  {-10, 3},
  {0.5, 0.5, 0.5, 0.5},
(*  PlotLabel -> "\:4e0d\:7a33\:5b9a\:7ed3\:70b9",*)
  AxesLabel -> xyLabel
]

p3 = plotPhasePortrait[
  0, 2, 
  {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == 0.5, x2[0] == 0}
  }, 
  {0, 10},
  {5, 5},
(*  PlotLabel -> "\:4e2d\:5fc3",*)
  AxesLabel -> xyLabel
]

p4 = plotPhasePortrait[
  -2, -1, 
  {
  {x1[0] == 1, x2[0] == 1},
  {x1[0] == -1, x2[0] == 1},
  {x1[0] == -1, x2[0] == -1},
  {x1[0] == 1, x2[0] == -1},
   {x1[0] == 0.5, x2[0] == 0.5},
  {x1[0] == -0.5, x2[0] == 0.5},
  {x1[0] == -0.5, x2[0] == -0.5},
  {x1[0] == 0.5, x2[0] == -0.5}
  }, 
  {-3, 1},
  {0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5},
 (* PlotLabel -> "\:978d\:70b9",*)
  AxesLabel -> xyLabel
]

p5 = plotPhasePortrait[
  0.5, 2, 
  {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == -1, x2[0] == 0}
  }, 
  {0, 10},
  {5, 5},
(*  PlotLabel -> "\:7a33\:5b9a\:7126\:70b9",*)
  AxesLabel -> xyLabel
]

p6 = plotPhasePortrait[
  -0.5, 2, 
  {
  {x1[0] == 0, x2[0] == 1},
  {x1[0] == 0, x2[0] == -1}
  }, 
  {-10, 2},
  {0, 0},
(*  PlotLabel -> "\:4e0d\:7a33\:5b9a\:7126\:70b9",*)
  AxesLabel -> xyLabel
]
GraphicsGrid[{{p1, p2}, {p3, p4}, {p5, p6}}]


(* \:7ed8\:5236\:4e8c\:6b21\:51fd\:6570\:56fe\:50cf *)
 figReg = ContourPlot[b^2 == 4 k, {k, -8, 8}, {b, -8, 8}, 
 ContourStyle -> Directive[Thick, Red], FrameLabel -> {"k", "b"}, 
 Axes -> True,
 Epilog -> {
    (* \:6dfb\:52a0\:5176\:4ed6\:56fe\:7247 *)
    Inset[p6, {6, 2}, {Center, Center}, 6],
    Inset[p5, {6, -2}, {Center, Center}, 6],
    Inset[p3, {3, 0}, {Center, Center}, 6],
    Inset[p2, {3, 6}, {Center, Center}, 6],
    Inset[p1, {3, -6}, {Center, Center}, 6],
    Inset[p4, {-3, 0}, {Center, Center}, 6]
  }
 ]


fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName];
SetName[n_] := ToString[StringForm["../figure/``.png", n]];

Export[SetName["region"], figReg];
