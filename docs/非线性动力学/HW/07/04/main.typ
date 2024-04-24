= 题 4

#figure(image("assets/2024-04-13-16-54-01.png"))

== 解

由多尺度法

$
cases(
  D_0^2 u_0 + omega_0^2 u_0 &= F cos 2 omega t,
  D_0^2 u_1 + omega_0^2 u_1 &= - 2 D_1 D_0 u_0 - 2 mu D_0 u_0 - omega_0^2 u_0^2
)
$

解得第一个为

$
u_0 &= A e^(i omega_0 T_0) + B e^(i 2 omega T_0) + "cc" quad A = a/2 e^(i phi), B = F/(2(omega_0^2 - (2 omega)^2))
$

代入第二个为

$
D_0^2 u_1 + omega_0^2 u_1 &= - 2 i omega_0 (D_1 A + mu A) e^(i omega_0 T_0) - 2 i omega B e^(i 2 omega T_0) \
&quad - omega_0^2 (A^2 e^(i 2 omega_0 T_0) + B^2 e^(i 4 omega T_0) + 2 A B e^(i (omega_0 + 2 omega)T_0) + 2 overline(A)B e^(i(2 omega - omega_0)T_0) + 2 A overline(B) e^(i(omega_0 - 2 omega)T_0)) + "cc"
$

当$2 omega - omega_0 approx omega_0$ 即$omega approx omega_0$时发生$1/2$亚谐波共振, 令$omega = omega_0 + epsilon sigma$

消除永年项

$
2 i omega_0 (D_1 A + mu A) + 2 omega_0^2 overline(A) B e^(i sigma T_1) = 0
$

令$beta = sigma T_1 - 2 phi$, 得

$
cases(
  D_1 a &= - mu a - omega_0 B a sin beta,
  D_1 phi &= sigma + omega_0 B cos beta
)
$

可得一次近似解为

$
u = a cos ((2 omega T_0 - phi(T_1))/2) + F/(omega_0^2 - (2 omega)^2) cos 2 omega t
$

分析稳定性

考虑渐近系统, 雅可比矩阵

$
J &= mat(
  - mu - omega_0 B sin beta, - omega_0 B a cos beta;
  0, - omega_0 B sin beta
)
$

要求特征值小于0. 得

$
cases(
  omega_0 B sin beta &> 0,
  omega_0 B sin beta + mu &> 0
)
$
