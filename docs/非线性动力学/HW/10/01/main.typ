#figure(image("assets/2024-04-29-09-07-22.png"))

== (1)

考虑一次渐近系统, 则Jacobian矩阵为

$
mat(
  delim:"[",
  &-sec(u_1 - u_2)^2, &sec(u_1 - u_2)^2;
  &-2 cos(u_1 + pi/6), &2^(u_2) ln 2
)
$

在$(0, 0)$处为

$
mat(
  delim:"[",
  &-1, &1;
  &-sqrt(3), &ln 2
)
$

特征方程为

$
lambda^2 - (ln 2 - 1) lambda + (sqrt(3) - ln 2) = 0
$

由Routh-Huruitz判据

$
Delta_0 = a_0 = 1 > 0, Delta_1 = a_1 = -(ln 2 - 1) > 0, Delta_2 = mat(
  delim:"|",
  a_1, a_0;
  0, a_2
) = a_1 a_2 = -(ln 2 - 1) (sqrt(3) - ln 2) > 0
$

可知, 特征值均有负实部, 系统渐近稳定

== (2)

考虑一次渐近系统, 则Jacobian矩阵为

$
mat(
  delim:"[",
  -(3 e^(-3 u_1))/(e^(-3 u_1)+4u_2), 4/(e^(-3 u_1)+4u_2);
  -2/(1 - 6 u_1)^(2/3), 2
)
$

在$(0, 0)$处为

$
mat(
  delim:"[",
  &-3, &4;
  &-2, &2
)
$

特征方程为

$
lambda^2 + lambda + 2 = 0
$

由Routh-Huruitz判据

$
Delta_0 = a_0 = 1 > 0, Delta_1 = a_1 = 1 > 0, Delta_2 = mat(
  delim:"|",
  a_1, a_0;
  0, a_2
) = a_1 a_2 = 2 > 0
$

可知, 特征值均有负实部, 系统渐近稳定