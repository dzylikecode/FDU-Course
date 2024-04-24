= 题 3

#figure(image("assets/2024-04-13-16-53-15.png"))

== 解

令

$ omega = omega_0 + epsilon sigma $

设一次近似解为

$ u = u_0 + epsilon u_1 $

多尺度法代入得到

$
cases(
  D_0^2 u_0 + omega_0^2 u_0 &= 0,
  D_0^2 u_1 + omega_0^2 u_0 &= f cos omega t - 2 D_0 D_1 u_0 - mu "sgn"(D_0 u_0) - omega_0^2 u_0^3
)
$

解

$ D_0^2 u_0 + omega_0^2 u_0 &= 0 $

得

$
u_0 = A(T_1) e^(i omega_0 T_0) + "cc" quad A = a/2 e^(i phi)
$

代入

$ D_0^2 u_1 + omega_0^2 u_0 &= f cos omega t - 2 D_0 D_1 u_0 - mu "sgn"(D_0 u_0) - omega_0^2 u_0^3 $

得

$
D_0^2 u_1 + omega_0^2 u_0 &= f/2 e^(i omega_0 T_0 + sigma T_1) - (2 i omega_0 D_1 A + 3 omega_0^2 A^2 overline(A)) - omega_0^2 A^3 e^(i 3 omega_0 T_0) + "cc" - mu "sgn"(i omega_0 e^(i omega_0 T_0) + "cc")
$

消除永年项

$ f/2 e^(i sigma T_1) - (2 i omega_0 D_1 A + 3 omega_0^2 A^2 overline(A)) - (mu omega_0)/(2 pi) integral_0^((2 pi)/omega_0) "sgn"(a cos omega_0 T_0) = 0 $

即

$
cases(
  D_1 a &= f/(2 omega_0) sin(sigma T_1 - phi) - (2 mu)/(pi omega_0),
  D_1 phi &= - f /(2 omega_0 a) cos(sigma T_1 - phi) + 3/8 omega_0 a^2
)
$

令$beta = sigma T_1 - phi$, 有

$
cases(
  D_1 a &= f/(2 omega_0) sin beta - (2 mu)/(pi omega_0),
  D_1 beta &= sigma + f /(2 omega_0 a) cos beta - 3/8 omega_0 a^2
)
$

令$D_1 a = D_1 beta = 0$, 得稳态解

$
cases(
  (2 mu)/(pi omega_0) &= f/(2 omega_0) sin beta,
  3/8 omega_0 a^2 - sigma &=  f /(2 omega_0 a) cos beta
)
$

得

$ ((2 mu)/(pi omega_0))^2 + (3/8 omega_0 a^2 - sigma)^2 a^2 = (f/(2 omega_0))^2 $

可知

当 $(2 mu)/(pi omega_0) < f/(2 omega_0)$ 即$f < (4 mu)/pi$, $a$ 无实数解, 无主共振

当$f > (4 mu)/pi$, 存在主共振