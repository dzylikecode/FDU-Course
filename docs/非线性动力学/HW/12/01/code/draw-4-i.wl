(* ::Package:: *)

(* \:5b9a\:4e49\:7ed8\:5236\:4e09\:7ef4\:76f8\:56fe\:7684\:51fd\:6570 *)
ClearAll[plotPhasePortrait3D]
plotPhasePortrait3D[
	eVal_,
	initialConditionsList_List, 
	tspan_List, 
	tArrow_List,
	opts : OptionsPattern[]
] := Module[
  (* \:5c40\:90e8\:53d8\:91cf *)
  {
    eqs, solutions, parametricPlots, arrows
  },
  
  (* \:5b9a\:4e49\:65b9\:7a0b\:7ec4 *)
  eqs = {
    x1'[t] == -2 * x1[t] + x2[t] + x3[t] + eVal * x1[t] - (x2[t])^2 * x3[t],
    x2'[t] == x1[t] - 2 * x2[t] + x3[t] + eVal * x1[t] + x1[t] * (x3[t])^2,
    x3'[t] == x1[t] + x2[t] + 2 * x3[t] + eVal * x1[t] + (x1[t])^2 * x2[t]
  };
  
  (* \:4f7f\:7528 NDSolve \:6c42\:89e3\:591a\:4e2a\:521d\:59cb\:6761\:4ef6\:7684\:65b9\:7a0b *)
  solutions = Table[
    NDSolve[
      {eqs, initCond}, {x1[t], x2[t], x3[t]}, {t, tspan[[1]], tspan[[2]]}
    ],
    {initCond, initialConditionsList}
  ];
  
  (* \:5355\:72ec\:7ed8\:5236\:6bcf\:6761\:8f68\:8ff9\:7684 ParametricPlot3D *)
  parametricPlots = Table[
    ParametricPlot3D[
      Evaluate[{x1[t], x2[t], x3[t]} /. solutions[[i, 1]]], {t, tspan[[1]], tspan[[2]]},
      PlotStyle -> {Thick}
    ],
    {i, Length[solutions]}
  ];
  
  (* \:4e3a\:6bcf\:6761\:8f68\:8ff9\:751f\:6210\:4e09\:7ef4\:7bad\:5934 *)
  arrows = Table[
    Graphics3D[
      Arrow[{
        {x1[t], x2[t], x3[t]} /. solutions[[i, 1]] /. t -> tArrow[[i]],
        {x1[t], x2[t], x3[t]} /. solutions[[i, 1]] /. t -> tArrow[[i]] + 0.1
      }]
    ],
    {i, Length[solutions]}
  ];
  
  (* \:663e\:793a\:5305\:542b\:7bad\:5934\:7684\:6240\:6709\:8f68\:8ff9\:ff0c\:5e94\:7528\:7528\:6237\:63d0\:4f9b\:7684\:989d\:5916\:9009\:9879 *)
  Show[
    Join[parametricPlots, arrows],
    opts
  ]
];

(* \:793a\:4f8b\:4f7f\:7528 *)
initialConditionsList = {
  {x1[0] == 0.15, x2[0] == 0.15, x3[0] == 0.15},
  {x1[0] == 0.15, x2[0] == 0.15, x3[0] == -0.15},
  {x1[0] == 0.15, x2[0] == -0.15, x3[0] == 0.15},
  {x1[0] == 0.15, x2[0] == -0.15, x3[0] == -0.15},
  {x1[0] == -0.15, x2[0] == 0.15, x3[0] == 0.15},
  {x1[0] == -0.15, x2[0] == 0.15, x3[0] == -0.15},
  {x1[0] == -0.15, x2[0] == -0.15, x3[0] == 0.15},
  {x1[0] == -0.15, x2[0] == -0.15, x3[0] == -0.15}
};

p1 = plotPhasePortrait3D[
  0.3,
  initialConditionsList, 
  {-0.8, 3.5},
  {-0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5},
  AxesLabel -> {"x", "y", "z"},
  PlotLabel -> "\[CurlyEpsilon] = 0.1",
  PlotRange -> {{-2, 2}, {-2, 2}, {-2, 2}}
]



p2 = plotPhasePortrait3D[
  -0.3,
  initialConditionsList, 
  {-0.8, 3.5},
  {-0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5},
  AxesLabel -> {"x", "y", "z"},
  PlotLabel -> "\[CurlyEpsilon] = -0.1",
  PlotRange -> {{-2, 2}, {-2, 2}, {-2, 2}}
]


fileName = NotebookFileName[];
curDir = NotebookDirectory[];
SetDirectory[curDir];
fileBaseName = FileBaseName[fileName];
SetName[n_] := ToString[StringForm["../figure/``.png", n]];

Export[SetName["4-i-p01"], p1];
Export[SetName["4-i-n01"], p2];
