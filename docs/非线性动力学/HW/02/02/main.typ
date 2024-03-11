#import "../lib/physic.typ": *

= 题 2

#image("assets/2024-03-10-22-30-36.png")

#figure(
  image("assets/2024-03-10-22-31-12.png", width: 50%)
)

== 约定

#let obj(sub) = (
  m: [$m_sub$],
  x: [$x_sub$],
  y: [$y_sub$],
)
#let OA = obj(3) // object A
#let OB = obj(4)
#let OC = obj(1)
#let OD = obj(2)

由题目可知, $A = OA.m, B = OB.m, C = OC.m, D = OD.m$.

== 约束

绳长不变

考虑第一段绳子

$
&(OD.y - l) + (OC.y - l) &&= l_2 \
arrow.l.r.double f_1 = &OD.y + OC.y - 2l - l_2 &&= 0
$

考虑第二段绳子

$
&(OA.y - OC.y) + (OB.y - OC.y) &&= l_1 \
arrow.l.r.double f_2 &= OA.y + OB.y - 2OC.y - l_1 &&= 0
$

=== 综上

$
cases(
  f_1 &= OD.y + OC.y - 2l - l_2 &&= 0,
  f_2 &= OA.y + OB.y - 2OC.y - l_1 &&= 0
)
$

== 方程

由#lagOne:

#lagEqOne

=== 驱动力

#let calcG(varX) = if varX == 1 [
  $m g$
] else [
  $varX m g$
]
#let G1 = calcG(1)
#let G2 = calcG(6)
#let G3 = calcG(2)
#let G4 = calcG(3)
#let Fx(sub) = [$F_(sub x)$]
#let Fy(sub) = [$F_(sub y)$]

#let calcF(sub, varG) = [$cases(
  Fx(sub) &= 0,
  Fy(sub) &= varG
)$]

$
calcF(1, G1) quad quad
calcF(2, G2) quad quad
calcF(3, G3) quad quad
calcF(4, G4)
$

=== 约束力

#let jacRow(sub) = [
  $
  (diff f_sub)/(diff x_1), (diff f_sub)/(diff y_1), (diff f_sub)/(diff x_2), (diff f_sub)/(diff y_2), (diff f_sub)/(diff x_3), (diff f_sub)/(diff y_3), (diff f_sub)/(diff x_4), (diff f_sub)/(diff y_4)
  $
]

$
bold(J) &= mat(
  jacRow(1);
  jacRow(2)
) \
&= mat(
  0, 1, 0, 1, 0, 0, 0, 0;
  0, -2, 0, 0, 0, 1, 0, 1;
)
$

=== 代入

$
cases(
  m acc(x, 1) = 0,
  m acc(y, 1) = m g + lambda_1 - 2 lambda_2,
  6m acc(x, 2) = 0,
  6m acc(y, 2) = 6 m g + lambda_1,
  2m acc(x, 3) = 0,
  2m acc(y, 3) = 2 m g + lambda_2,
  3m acc(x, 4) = 0,
  3m acc(y, 4) = 3 m g + lambda_2
)
$

=== 约束等价变换

考虑二阶导

$
cases(
  acc(y, 2) + acc(y, 1) &= 0,
  acc(y, 3) + acc(y, 4) - 2 acc(y, 1) &= 0
)
$

=== 解方程

$
cases(
  acc(x, 1) = 0,
  acc(y, 1) = - g/59,
  acc(x, 2) = 0,
  acc(y, 2) = g/59,
  acc(x, 3) = 0,
  acc(y, 3) = - (13 g)/59,
  acc(x, 4) = 0,
  acc(y, 4) = (11 g)/59,
  lambda_1 = - (348 g m)/59,
  lambda_2 = - (144 g m)/59
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

  $
  cases(
    accForm(1) &&= - g/59 vecY,
    accForm(2) &&= g/59 vecY,
    accForm(3) &&= - (13 g)/59 vecY,
    accForm(4) &&= (11 g)/59 vecY
  )
  $
}