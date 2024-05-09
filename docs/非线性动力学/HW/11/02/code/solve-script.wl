(* ::Package:: *)

A = {
{0, 1},
{-k, -b}
};
A // MatrixForm


evalA[bV_, kV_] := {
{0, 1},
{-kV, -bV}
};


evalA[2, 3] // MatrixForm


x[t_] := {x1[t], x2[t]}
AValue = evalA[2, 0.5]


eqs = x'[t] == AValue . x[t]


initialConditionsList = {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == -1, x2[0] == 0},
  {x1[0] == 0.5, x2[0] == 0.5},
  {x1[0] == -0.5, x2[0] == -0.5},
  {x1[0] == 1.5, x2[0] == -0.5}
}


solutions = Table[
  DSolve[{eqs, initialConditions}, {x1[t], x2[t]}, t],
  {initialConditions, initialConditionsList}
]


parametricPlots = Table[
  ParametricPlot[
    Evaluate[{x1[t], x2[t]} /. solutions[[i, 1]]], {t, 0, 10},
    PlotStyle -> {Thick},
    PlotRange -> {{-2, 2}, {-2, 2}}],
  {i, Length[solutions]}
];


Show[parametricPlots, PlotLabel -> "Multiple Initial Conditions Phase Portrait", 
 AxesLabel -> {"x1[t]", "x2[t]"}]


parametricPlots = Table[
  Module[{solution = solutions[[i, 1]], arrow},
    (* \:751f\:6210\:5355\:4e2a\:7bad\:5934 *)
    arrow = Arrow[{
      {x1[t], x2[t]} /. solution /. t -> 5, (* \:5728 t = 5 \:7684\:70b9\:6dfb\:52a0\:7bad\:5934 *)
      {x1[t], x2[t]} /. solution /. t -> 5.1
    }];

    (* \:7ed8\:5236\:5e26\:7bad\:5934\:7684 ParametricPlot *)
    ParametricPlot[
      Evaluate[{x1[t], x2[t]} /. solution], {t, 0, 10},
      PlotStyle -> {Thick},
      PlotRange -> {{-2, 2}, {-2, 2}},
      Epilog -> {arrow}
    ]
  ],
  {i, Length[solutions]}
]


Show[parametricPlots, PlotLabel -> "Multiple Initial Conditions Phase Portrait",
 AxesLabel -> {"x1[t]", "x2[t]"}]


parametricPlots = Table[
  ParametricPlot[
    Evaluate[{x1[t], x2[t]} /. solutions[[i, 1]]], {t, 0, 10},
    PlotStyle -> {Thick},
    PlotRange -> {{-2, 2}, {-2, 2}}
  ],
  {i, Length[solutions]}
];

(* \:4e3a\:6bcf\:6761\:8f68\:8ff9\:751f\:6210\:7bad\:5934 *)
arrows = Table[
  Arrow[{
    {x1[t], x2[t]} /. solutions[[i, 1]] /. t -> 5, (* \:5728 t = 5 \:7684\:70b9\:6dfb\:52a0\:7bad\:5934 *)
    {x1[t], x2[t]} /. solutions[[i, 1]] /. t -> 5.1
  }],
  {i, Length[solutions]}
];

(* \:663e\:793a\:5305\:542b\:7bad\:5934\:7684\:6240\:6709\:8f68\:8ff9 *)
Show[parametricPlots, PlotLabel -> "Multiple Initial Conditions Phase Portrait",
 AxesLabel -> {"x1[t]", "x2[t]"}, Epilog -> arrows]


ClearAll[plotPhasePortrait]
plotPhasePortrait[bVal_, kVal_, initialConditionsList_, tspan_] := Module[
  {
    A, eqs, solutions, parametricPlots, arrows, tMiddle
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
    DSolve[{eqs, initialConditions}, {x1[t], x2[t]}, t],
    {initialConditions, initialConditionsList_}
  ];
  
  (* \:8ba1\:7b97\:4e2d\:95f4\:65f6\:95f4\:70b9 *)
  tMiddle = Mean[tspan_];
  
  (* \:5355\:72ec\:7ed8\:5236\:6bcf\:6761\:8f68\:8ff9\:7684 ParametricPlot *)
  parametricPlots = Table[
    ParametricPlot[
      Evaluate[{x1[t], x2[t]} /. solutions[[i, 1]]], tspan_,
      PlotStyle -> {Thick},
      PlotRange -> {{-2, 2}, {-2, 2}}
    ],
    {i, Length[solutions]}
  ];
  
  (* \:4e3a\:6bcf\:6761\:8f68\:8ff9\:751f\:6210\:7bad\:5934 *)
  arrows = Table[
    Arrow[{
      {x1[t], x2[t]} /. solutions[[i, 1]] /. t -> tMiddle,
      {x1[t], x2[t]} /. solutions[[i, 1]] /. t -> tMiddle + 0.1
    }],
    {i, Length[solutions]}
  ];
  
  (* \:663e\:793a\:5305\:542b\:7bad\:5934\:7684\:6240\:6709\:8f68\:8ff9 *)
  Show[
    parametricPlots,
    PlotLabel -> "Multiple Initial Conditions Phase Portrait",
    AxesLabel -> {"x1[t]", "x2[t]"},
    Epilog -> arrows
  ]
];

(* \:793a\:4f8b\:4f7f\:7528 *)
initialConditionsList = {
  {x1[0] == 1, x2[0] == 0},
  {x1[0] == -1, x2[0] == 0},
  {x1[0] == 0.5, x2[0] == 0.5},
  {x1[0] == -0.5, x2[0] == -0.5},
  {x1[0] == 1.5, x2[0] == -0.5}
};

plotPhasePortrait[0.5, 2, initialConditionsList, {0, 10}]
