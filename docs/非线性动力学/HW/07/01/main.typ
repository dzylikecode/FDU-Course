= 题 1

#figure(image("assets/2024-04-13-16-12-29.png"))

#figure(image("assets/2024-04-13-16-14-36.png"))

== (1)

将周期解作有限Fourier展开

$ u= A cos omega t $

将p做有限Fourier展开(先做泰勒展开, 然后代入)

$
sin u &= u - u^3 / 3! + o(u^4) \
&approx u - u^3 / 6 \
&= (A cos omega t) - (A cos omega t)^3 / 6
$

代入原方程中

$
(1 - omega^2 - 1/8 A^2)A cos omega t - 1/24 A^3 cos 3 omega t = 0
$

由一次谐波平衡

$
(1 - omega^2 - 1/8 A^2)A = 0
$

所以

$
omega = sqrt(1 - 1/8 A^2)
$

解为

$
u = A cos sqrt(1 - 1/8 A^2) t
$

== (2)

将周期解作有限Fourier展开

$ u= A cos omega t $

代入原方程中

$
1/2 epsilon A^2 + (1-omega^2+3/4 epsilon A^2)A cos omega t + 1/2 epsilon A^2 cos 2 omega t + 1/4 epsilon A^3 cos 3 omega t = 0
$

由一次谐波平衡:

$
(1 - omega^2 + 3/4 epsilon A^2)A = 0
$

所以

$
omega = sqrt(1 + 3/4 epsilon A^2)
$

解为

$
u = A cos sqrt(1 + 3/4 epsilon A^2) t
$