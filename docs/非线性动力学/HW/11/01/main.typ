#import "@preview/physica:0.9.1": *


= 题 1

#figure(image("assets/2024-05-08-16-25-13.png"))

== 解

求解特征值为

$
a &= (1 plus.minus i sqrt(15))/2 \
b &= (-1 plus.minus i sqrt(15))/2 \
c &= (1 plus.minus i sqrt(15))/2 \
d &= plus.minus i \
e &= plus.minus i \
f &= (-1 plus.minus i sqrt(15))/2 \
$

由此可以分类

=== 不稳定

有方程$a, c$和图$3, 7$

考虑点$x = 0, y > 0$处的点, 此时

$
cases(
  dot(x) &= 5 y,
  dot(y) &= -2 y
)
$

考虑下一时刻则有

$
cases(
  dot(x) &> 0,
  dot(y) &< 0
)
$

即$x$增大, $y$减小, 与图3对应

或者考虑

$
dv(y, x) = (dv(y, t))/(dv(x, t)) = (dot(y))/(dot(x)) = -2/5 < 0
$

在此处的切线斜率小于0, 所以也是图3

因而有

$
a &arrow.r 3 \
c &arrow.r 7
$

== 渐近稳定

有方程$b, f$和图$4, 5$

同理可得

$
b &arrow.r 5 \
f &arrow.r 4
$

== 中心

有方程$d, e$和图$1, 2$

同理可得

$
d &arrow.r 1 \
e &arrow.r 2
$

综上

$
a &arrow.r 3 \
b &arrow.r 5 \
c &arrow.r 7 \
d &arrow.r 1 \
e &arrow.r 2 \
f &arrow.r 4
$