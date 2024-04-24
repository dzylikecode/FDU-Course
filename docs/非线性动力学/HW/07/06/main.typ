= 题 6

#figure(image("assets/2024-04-14-21-39-37.png"))

== 解

可求得

$ theta = omega_0 t + epsilon sigma_0 t + r/2 (epsilon t)^2 + theta_0 $

可以设为

$
theta = omega_0 T_0 + phi(T_1)
$

同样可由多尺度法, 代入

$
cases(
  D_1 a &= - 1/(2 pi omega_0) integral_0^(2 pi) p(a cos psi, - omega_0 a sin psi) sin psi dif psi,
  D_1 phi &= - 1/(2 pi omega_0 a) integral_0^(2 pi) p(a cos psi, - omega_0 a sin psi) cos psi dif psi,
)
$

得

$
cases(
  D_1 a &= f/ (2 omega_0) sin phi - (2 mu)/(pi omega_0),
  D_1 phi &= (sigma_0 + r T_1) - 3/8 omega_0 a^2 + f/(2 omega_0) cos phi
)
$

得一次近似解为

$ u = a cos (theta - phi(T_1)) $