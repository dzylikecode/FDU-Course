#import "../lib/physic.typ": *

= 题 4

#image("assets/2024-03-11-15-11-29.png")

#figure(
  image("assets/2024-03-11-15-11-50.png", width: 50%)
)

== 约定

#let xAB = [$x_(A B)$]
#let yAB = [$y_(A B)$]

设小球的质心坐标为$(x_c, y_c)$, 薄平板的质心坐标为$(#xAB, #yAB)$

== 约束

由于水平放置, 所以

$ theta_(A B) = 0 $

直接以水平考虑

=== 薄板

$ #yAB = C_1 $

=== 小球

变换坐标系思考, 考虑小球相对薄板的运动

#let xCAB = [$x_C^(A B)$]
#let yCAB = [$y_C^(A B)$]

$
cases(
  #xCAB = x_c - #xAB,
  #yCAB = y_c - #yAB
)
$

接触的约束为

$
&#yCAB = C_2 \
arrow.l.r.double &y_c - #yAB = C_2
$

纯滚动的约束为

$
&#xCAB = R phi \
arrow.l.r.double &x_c - #xAB = R phi
$

=== 综上

$
cases(
  f_1 &= #yAB - C_1 &&= 0,
  f_2 &= y_c - #yAB - C_2 &&= 0,
  f_3 &= x_c - #xAB - R phi &&= 0
)
$

== 方程

由#lagOne:

#lagEqOne

=== 驱动力

#let Fx(sub) = [$F_(sub x)$]
#let Fy(sub) = [$F_(sub y)$]
#let mAB = [$m_(A B)$]

$
cases(
  Fx(2) = 0,
  Fy(2) = m_C g,
  M = 0,
)
quad quad
cases(
  Fx(1) = 0,
  Fy(1) = #mAB g
)
$

#move(
  dx: 350pt,
  dy: -40pt,
  rect(
    width: 100pt,
    height: 20pt,
    [
      容易忽略转动
    ]
  )
)

=== 约束力

#let jacRow(sub) = [
  $
  (diff f_sub)/(diff x_C), (diff f_sub)/(diff y_C), (diff f_sub) / (diff phi), (diff f_sub)/(diff #xAB), (diff f_sub)/(diff #yAB)
  $
]

$
bold(J) &= mat(
  jacRow(1);
  jacRow(2);
  jacRow(3);
) \
&= mat(
  0, 0, 0, 0, 1;
  0, 1, 0, 0, -1;
  1, 0, -R, -1, 0;
)
$

=== 代入

$
cases(
  m_C acc(x, C) &= lambda_3,
  m_C acc(y, C) &= m_C g + lambda_2,
  1/2 m_C R^2 acc(phi, "") &= - R lambda_3,
  #mAB acc(x, A B) &= F - lambda_3,
  #mAB acc(y, A B) &= #mAB g + lambda_1 - lambda_2
)
$

=== 约束等价变换

$
cases(
  acc(y, A B) &= 0,
  acc(y, C) - acc(y, A B) &= 0,
  acc(x, C) - acc(x, A B) - R acc(phi, "") &= 0
)
$

=== 解方程

#let dC = [$3 #mAB + m_C$]
#let dAB = $(#dC) R$

$
cases(
  acc(x, C) &= F / #dC,
  acc(y, C) &= 0,
  acc(phi, "") &= -(2F) / #dAB,
  acc(x, A B) &= (3F) / #dC,
  acc(y, A B) &= 0,
  lambda_1 &= - (#mAB + m_C) g,
  lambda_2 &= - m_C g,
  lambda_3 &= (F m_C) / #dC
)
$