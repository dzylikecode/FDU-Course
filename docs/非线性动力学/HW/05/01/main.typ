#import "@preview/physica:0.9.2": *
#import "@preview/colorful-boxes:1.2.0": *

#set math.equation(numbering: "(1)")
#show link: it => text(fill:blue, underline(it))

#show ref: it => {
  let eq = math.equation
  let el = it.element
  if el != none and el.func() == eq {
    // Override equation references.
    numbering(
      el.numbering,
      ..counter(eq).at(el.location())
    )
  } else {
    // Other references as usual.
    it
  }
}


= 题 1

#figure(image("assets/2024-04-01-17-03-33.png"))

== 直接摄动法

二次近似

$ u(epsilon, t) = u_0(t) +  epsilon u_1(t) + epsilon^2 u_2(t) $

代入方程

#let dduSub = $
dot.double(u)_0 + epsilon dot.double(u)_1 + epsilon^2 dot.double(u)_2
$
#let uSub = $
u_0 + epsilon u_1 + epsilon^2 u_2
$

$
(dduSub) + (uSub) + epsilon (uSub)^2 = 0
$

可得

$
cases(
  dot.double(u)_0 + u_0 &= 0,
  dot.double(u)_1 + u_1 &= - u_0^2,
  dot.double(u)_2 + u_2 &= - 2 u_0 u_1
)
$

迭代

解

$ 
cases(
dot.double(u)_0 + u_0 &= 0,
u_0(0) &= a,
dot(u)_0(0) &= 0
)
$

得

$ u_0= a cos t $

代入

$ 
cases(
dot.double(u)_1 + u_1 &= - u_0^2,
u_1(0) &= 0,
dot(u)_1(0) &= 0
)
$

解得

$
u_1(t) = a^2/6 (cos 2 t + 2 cos t - 3)
$

代入到

$ 
cases(
dot.double(u)_2 + u_2 &= - 2 u_0 u_1,
u_2(0) &= 0,
dot(u)_2(0) &= 0
)
$

解得

$
u_2(t) = a^3/144 (3 cos 3 t + 16 cos 2 t + 29 cos t + 60 t sin t - 48)
$

二次近似

$
u(t) &= u_0(t) + epsilon u_1(t) + epsilon^2 u_2(t) \
&= a cos t + (epsilon a^2)/6 (cos 2 t + 2 cos t - 3) \
&quad + (epsilon^2 a^3)/144 (3 cos 3 t + 16 cos 2 t + 29 cos t + 60 t sin t - 48)
$

== LP 摄动法

做二次近似

$
u(epsilon, t) &= u_0(t) +  epsilon u_1(t) + epsilon^2 u_2(t) \
omega(epsilon)^2 &= omega_0^2 + epsilon b_1 + epsilon^2 b_2
$

则有

$
omega_0^2 &= omega^2 - epsilon b_1 - epsilon^2 b_2
$

代入方程合并同类项有:

$
cases(
  dot.double(u)_0 + omega^2 u_0 &= 0,
  dot.double(u)_1 + omega^2 u_1 &= b_1 u_0 - u_0^2,
  dot.double(u)_2 + omega^2 u_2 &= b_2 u_0 + b_1 u_1 - 2 u_0 u_1
)
$ <eq2-all>

解

$
cases(
dot.double(u)_0 + omega u_0 &= 0,
u_0(0) &= a,
dot(u)_0(0) &= 0
)
$

得

$
u_0= a cos omega t
$

代入有

$
cases(
  dot.double(u)_1 + omega u_1 &= b_1 u_0 - u_0^2,
  u_1(0) &= 0,
  dot(u)_1(0) &= 0
)
$

其中$cos omega t$的系数为$b_1$, 为避免永年项, 取$b_1 = 0$

解得

$
u_1(t) = 1/(6 omega^2) (2 a^2 cos omega t + a^2 cos 2 omega t -3 a^2)
$


代入

$
cases(
  dot.double(u)_2 + omega^2 u_2 &= b_2 u_0 + b_1 u_1 - 2 u_0 u_1,
  u_2(0) &= 0,
  dot(u)_2(0) &= 0
)
$

令$cos omega t$的系数为0

$ (5 a^3 + 6 a omega^2 b_2)/(6 omega^2) = 0 $

解得

$
b_2 = - 5/6 a^2/omega^2
$

解得方程为

$
u_2(t) = 1/(144 omega^2)(3 a^3 cos 3 omega t + 16 a^3 cos 2 omega t + 29 a^3 cos omega t - 48 a^3)
$

可得

$
omega &= sqrt(omega_0^2 + epsilon b_1 + epsilon^2 b_2) \
&= sqrt(1 - epsilon^2 (5 a^2)/(6 omega^2))
$