#figure(image("assets/2024-04-29-09-31-49.png"))

== 解

考虑一次渐近系统, 则Jacobian矩阵为

$
mat(
  delim:"[",
  -14u_1+2, -5;
  3, -18u_2-6
)
$

在$(0, 0)$处为

$
mat(
  delim:"[",
  -12, -5;
  3, 12
)
$

特征方程为

$
lambda^2 -129 = 0
$

特征值为

$ lambda = plus.minus sqrt(129) i $

系统不稳定
