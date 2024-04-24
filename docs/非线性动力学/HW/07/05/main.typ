= 题 5

#figure(image("assets/2024-04-14-21-38-58.png"))

== (1)

多尺度法, 有

$
cases(
  D_0^2 u_0 + omega_0^2 u_0 &= F_2 cos omega_2 T_0,
  D_0^2 u_1 + omega_0^2 u_1 &= - 2 D_1 D_0 u_0 - 2 mu D_0 u_0 - u_0^3 + f cos omega_1 T_0
)
$

解得第一个为

$
u_0 &= A e^(i omega_0 T_0) + B e^(i omega_2 T_0) + "cc" quad A = a/2 e^(i phi), B = F/(2(omega_0^2 - omega_2^2))
$

代入第二个为

$
D_0^2 u_1 + omega_0^2 u_1 &= - 2 i omega_0 (D_1 A + mu A) e^(i omega_0 T_0) - 2 i omega_2 B e^(i 2 omega T_0) \
&quad - omega_0^2 (A^3 e^(i 3 omega_0 T_0) + B^3 e^(i 3 omega_2 T_0) + 3 A^2 B e^(i (2 omega_0 + omega_2)T_0) + 3 overline(A)^2 B e^(i(omega_2 - 2 omega_0)T_0) + 3 A B^2 e^(i(omega_0 + 2 omega)T_0) \
&quad + 3 A overline(B)^2 e^(i(omega_0 - 2 omega)T_0) + 6 A B^2 e^(i omega_0 T_0) + 3 A^2 overline(A) e^(i omega_0 T_0) + 3 B^3 e^(i omega_2 T_0) + 6 A overline(A)B e^(i omega_2 T_0)) + f/2 e^(i omega_1 T_0)+ "cc"
$

其中$omega_0 = 1$, 设 $omega_1  = 1 + epsilon sigma, omega_2 = 3 + epsilon sigma$

消除永年项有

$
2 i D_1 A + 2 mu i A + 3 overline(A)^2 B e^(i sigma_2 T_1) + 6 A B^2 + 3 A^2 overline(A) - f/2 e^(i sigma_1 T_1)
$

得

$
cases(
  D_1 a &= - mu a - 3/4 a^2 B sin phi + f/2 sin (sigma_1 T_1 + (phi - sigma_2 T_1)/3),
  D_1 phi &= sigma - 9/4 B a cos phi + 3/2 f cos (sigma_1 T_1 + (phi - sigma_2 T_1)/3) + 9/8 a^2 + 9 B^2
)
$

解得一次近似解为

$
u = a cos (omega T_0 - phi)/3 + B cos omega_2 T_0
$

== (2)

若近似解为周期解, 则有

$ dot(phi) = 0 $

则有

$ sigma_1 - sigma_2 /3 = 0 $

得

$
omega_1/omega_2 = (1 + epsilon sigma_1)/(3 + epsilon sigma_2) = 1/3
$