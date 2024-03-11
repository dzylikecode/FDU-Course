#import "../lib/physic.typ": *

= 题 3

#image("assets/2024-03-11-09-32-58.png")

#figure(
  image("assets/2024-03-11-09-33-48.png", width: 50%)
)

== 约定

如图采用极坐标系

== 约束

由绳长不变

$
&x_1 + 2 x_2 + x_3 &&= l \
arrow.l.r.double f = &x_1 + 2 x_2 + x_3 - l &&= 0
$

== 方程

由#lagOne:

#lagEqOne

=== 驱动力

此时采用的是广义坐标, 通过能量来求驱动力

$
delta W = m g sin theta delta x_1 + m g delta x_2 + m g sin phi delta x_3
$

因此, 驱动力为

$
cases(
  Q_1 = m g sin theta,
  Q_2 = m g,
  Q_3 = m g sin phi
)
$

=== 约束力
$
bold(J) &= mat(
    (diff f)/(diff x_1),  (diff f)/(diff x_2), (diff f)/(diff x_3);
) \
&= mat(
  1, 2, 1;
)
$

=== 代入

$
cases(
  m acc(x, 1) = m g sin theta + lambda,
  m acc(x, 2) = m g + 2 lambda,
  m acc(x, 3) = m g sin phi + lambda
)
$

=== 约束等价变换

$
acc(x, 1) + 2 acc(x, 2) + acc(x, 3) = 0
$

=== 解方程

$
cases(
  acc(x, 1) = 1/6(-2 - sin phi + 5 sin theta) g,
  acc(x, 2) = 1/3(1 - sin phi - sin theta) g,
  acc(x, 3) = 1/6(-2 + 5 sin phi - sin theta) g,
  lambda = 1/6(-2 - sin phi + 5 sin theta) m g
)
$