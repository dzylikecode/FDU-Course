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

#figure(image("assets/2024-04-01-15-13-56.png"))

== 解

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
(dduSub) + omega_0^2 (uSub) + epsilon omega_0^2 (uSub)^3 = 0
$

可得

$
cases(
  dot.double(u)_0 + omega_0^2 u_0 &= 0,
  dot.double(u)_1 + omega_0^2 u_1 &= - omega_0^2 u_0^3,
  dot.double(u)_2 + omega_0^2 u_2 &= - 3 omega_0^2 u_0^2 u_1
)
$

== 迭代

解

$ dot.double(u)_0 + omega_0^2 u_0 &= 0 $

得

$ u_0 = A cos omega_0 t + B sin omega_0 t $

代入初值$u(0) = a_0, dot(u)(0) = 0$得到

$ u_0= a_0 cos omega_0 t $

代入

$ dot.double(u)_1 + omega_0^2 u_1 &= - omega_0^2 u_0^3 $

得

$ dot.double(u)_1 + omega_0^2 u_1 &= - omega_0^2 (a_0 cos omega_0 t)^3 $

由$cos 3 theta = 4 cos^3 theta - 3 cos theta$ 得

$ dot.double(u)_1 + omega_0^2 u_1 &= -1/4 omega_0^2 a_0^3(cos 3 omega_0 t + 3 cos omega_0 t) $

结合初值

$
cases(
  u_1 &= 0,
  dot(u)_1 &= 0
)
$

解得

$
u_1(t) = a^3/32 (cos 3 omega_0 t - cos omega_0 t - 12 omega_0 t sin omega_0 t)
$

所以一次近似系统解为

$
u(t) &= u_0(t) + epsilon u_1(t) \
&= a_0 cos omega_0 t +  (epsilon a^3)/32 (cos 3 omega_0 t - cos omega_0 t - 12 omega_0 t sin omega_0 t)
$

代入到

$ dot.double(u)_2 + omega_0^2 u_2 &= - 3 omega_0^2 u_0^2 u_1 $

得到

$
dot.double(u)_2 + omega_0^2 u_2 &= - (3 omega_0^2 a^3)/32 (a_0 cos omega_0 t)^2 (cos 3 omega_0 t - cos omega_0 t - 12 omega_0 t sin omega_0 t)
$

结合初值

$
cases(
  u_2 &= 0,
  dot(u)_2 &= 0
)
$

解得

$
u_2(t) = a^5/1024 (cos 5 omega_0 t - 24 cos 3 omega_0 t + (23 - 72 omega_0^2 t^2) cos omega_0 t  \
- 36 omega_0 t sin 3 omega_0 t + 96 omega_0 t sin omega_0 t)
$

二次近似

$
u(t) &= u_0(t) + epsilon u_1(t) + epsilon^2 u_2(t) \
&= a_0 cos omega_0 t +  (epsilon a^3)/32 (cos 3 omega_0 t - cos omega_0 t - 12 omega_0 t sin omega_0 t) \
&quad + (epsilon^2 a^5)/1024 (cos 5 omega_0 t - 24 cos 3 omega_0 t + (23 - 72 omega_0^2 t^2) cos omega_0 t  \
&quad - 36 omega_0 t sin 3 omega_0 t + 96 omega_0 t sin omega_0 t)
$

== 比较

#table(
  columns: 2,
  stroke: none,
  image("figure/01.png"),
  image("figure/02.png"),
)