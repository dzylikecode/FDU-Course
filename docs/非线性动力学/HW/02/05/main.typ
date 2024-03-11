#import "../lib/physic.typ": *

= 题 5

#image("assets/2024-03-11-17-09-23.png")

#figure(
  image("assets/2024-03-11-17-09-36.png", width: 50%)
)

== 约定

设质心为$(x_c, y_c)$, 杆转动的角度为$theta$

== 约束

易知, 对$A, B$的约束等价于对$C$的约束: $V_c$垂直于杆, 即

#let Vxc = $dot(x)_c$
#let Vyc = $dot(y)_c$

$
&(Vxc, Vyc) dot (cos theta, sin  theta) &&= 0 \
arrow.l.r.double & Vxc cos theta + Vyc sin theta &&= 0 \
arrow.l.r.double & cos theta delta x+ sin theta delta y&&= 0 
$

=== 综上

$
delta f = cos theta delta x+ sin theta delta y = 0
$

== 方程

由#routh:

#routhEq

=== 能量

动能

$
T &= 1/2 m_c v^2_c + 1/2 J_c omega^2 \
&= 1/2 (2m)(dot(x)^2_c + dot(y)^2_c) + 1/2 (m (l/2)^2 + m (l/2)^2) dot(theta)^2 \
&= m (dot(x)^2_c + dot(y)^2_c) + 1/4 m l^2 dot(theta)^2
$

势能

$ V = 0 $

所以

$ L = m (dot(x)^2_c + dot(y)^2_c) + 1/4 m l^2 dot(theta)^2 $

=== 广义力

$ Q = 0 $

=== 约束

$
bold(J) &= mat(
  (diff f) / (diff x_c), (diff f) / (diff y_c), (diff f) / (diff theta);
) \
&= mat(
  cos theta, sin theta, 0;
)
$

=== 代入

$
cases(
  2m acc(x, c) &= lambda cos theta ,
  2m acc(y, c) &= lambda sin theta ,
  1/2 m l^2 acc(theta, "") &= 0
)
$

=== 解方程

知$theta = omega t$

所以

$
cases(
  2m Vxc &= lambda/omega sin omega t,
  2m Vyc &= -lambda/omega cos omega t,
)
$

代入约束中, 恒成立

考虑初值, 则有

$
&2 m Vyc(0) &&= -lambda/omega \
arrow.l.r.double &lambda &&= -2 m Vyc(0) omega
$

则有

$
cases(
  x_c &= - lambda /(2m omega^2) cos omega t + x_0 &&= Vyc(0)/omega cos omega t + x_0,
  y_c &= - lambda /(2m omega^2) sin omega t + y_0 &&= Vyc(0)/omega sin omega t + y_0,
)
$