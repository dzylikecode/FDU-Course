#import "fig1.typ": fig1, fig2
  
  #let lagOne = [第一类拉格朗日方程]
  #let acc(var, sub) = [$dot.double(var)_sub$]
  #let lagEqOne = [
    $
    cases(
      F_"ix" - m_i acc(x, i) + sum_(j=0)^r lambda_j (diff f_j)/(diff x_i)= 0,
      F_"iy" - m_i acc(y, i) + sum_(j=0)^r lambda_j (diff f_j)/(diff y_i)= 0,
      (i = 1, 2, dots, n)
    )
    $
  ]

= 题 1

#image("assets/2024-03-10-16-42-28.png")

设$m_1$的质心为$(x_1, y_1)$, $m_2$的质心为$(x_2, y_2)$

== 考虑约束:

=== $m_2$的约束

$ y_2 = C_2 $

=== $m_1$的约束

需要变换参考系思考, $m_1$在$m_2$参考系的坐标为

#let x1m2 = [$x_1 - x_2$]
#let y1m2 = [$y_1 - y_2$]

$ x_1^(m_2) &= #x1m2 \
  y_1^(m_2) &= #y1m2 $

#let explain = [
    设$A$坐标为$(0, C_A)$, 依据斜率恒定, 则有

    $ &-tan theta = k = (y_1^(m_2) - C_A)/(x_1^(m_2)) \ 
    arrow.l.r.double &-x_1^(m_2)  tan theta = y_1^(m_2) - C_A \
    arrow.l.r.double &(#x1m2)  tan theta + (#y1m2) - C_A = 0\
    $
  ]

#let source = box(explain, width: 100%)

#table(
  columns: 2,
  stroke: none,
  align: (center + horizon, center + horizon),
  fig1,
  source
)

综上, 约束方程为:

$
f_1 &= (x_1 - x_2)  tan theta + (y_1 - y_2) - C_A &&= 0 \
f_2 &= y_2 - C_2 &&= 0 \
$

== 力学方程

由#lagOne:

#lagEqOne

计算

$
cases(
  F_"1x" = 0,
  F_"1y" = -m_1 g
)
quad quad
cases(
  F_"2x" = 0,
  F_"2y" = -m_2 g
)
$

#let jacRow(sub) = [
  $
  (diff f_sub)/(diff x_1), (diff f_sub)/(diff y_1), (diff f_sub)/(diff x_2), (diff f_sub)/(diff y_2)
  $
]

$
bold(J) &= mat(
  jacRow(1);
  jacRow(2)
) \
&= mat(
  tan theta, 1, -tan theta, -1;
  0, 0, 0, 1;
)
$

#let lagInMatrix = [
  容易观察, #lagOne 可以写成矩阵形式:

  $ bold(F) - bold(M) bold(a) + bold(J)^T bold(lambda) = 0 $
]

#place(
  dx: 330pt,
  dy: -80pt,
  rect(
    width: 120pt,
    lagInMatrix
  )
)

代入可得

$
m_1 acc(x, 1) &= lambda_1 tan theta \
m_1 acc(y, 1) &= -m_1 g + lambda_1 \
m_2 acc(x, 2) &= -lambda_1 tan theta \
m_2 acc(y, 2) &= -m_2 g -lambda_1 + lambda_2
$

== 解方程

考虑约束, 去掉常数, 考虑微分关系

$
(acc(x, 1) - acc(x, 2)) tan theta + (acc(y, 1) - acc(y, 2)) &= 0 \
acc(y, 2) &= 0
$

联立, 解得


#let solOf1 = {
  let t   = [$tan theta$]
  let t2  = [$tan^2 theta$]
  let d   = [$t2 m_1 + (1+t2)m_2$]
  (
    x1: [$(m_2 g #t) / #d$],
    y1: [$-((m_1+m_2)g #t)/#d$],
    x2: [$-(m_1 g #t)/#d$],
    y2: [0],
    lambda1: [$(m_1 m_2 g)/#d$],
    lambda2: [$((m_1+m_2) m_2 g(1+#t2))/#d$]
  )
}

$
cases(
  acc(x, 1) = solOf1.x1,
  acc(y, 1) = solOf1.y1,
  acc(x, 2) = solOf1.x2,
  acc(y, 2) = solOf1.y2,
  lambda_1  = solOf1.lambda1,
  lambda_2  = solOf1.lambda2
)
$

== 结论

加速度为

#{
  let vecX = [$bold(mono(i))$]
  let vecY = [$bold(mono(j))$]
  let accForm(sub) = [
    $bold(a)_sub &= acc(x, sub) vecX + acc(y, sub) vecY$
  ]

  [
    $
    accForm(1) &&= solOf1.x1 vecX solOf1.y1 vecY \
    accForm(2) &&= solOf1.x2 vecX
    $
  ]
}

约束力为

#{
  let vecX = [$bold(mono(i))$]
  let vecY = [$bold(mono(j))$]
  let forceForm(sub) = [
    $bold(F)_sub &= lambda_sub ((diff f_sub)/(diff x_sub)vecX + (diff f_sub)/(diff y_sub) vecY)$
  ]

  [
    $
    forceForm(1) &&= solOf1.lambda1 (tan theta vecX + 1 vecY) \
    forceForm(2) &&= solOf1.lambda1 vecY
    $
  ]
}