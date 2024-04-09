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


= 题 2

#figure(image("assets/2024-04-01-21-36-44.png"))

== 1 建立方程

由牛顿定律

$
cases(
  m g - q(u_g) &= 0,
  m g - q(u_g + u) &= m dot.double(u)
)
$

#let acc(..sink) = {
  let args = sink.pos()
  if args.len() == 1 {
    let var = args.at(0)
    $dot.double(var)$
  } else if args.len() == 2 {
    let var = args.at(0)
    let sub = args.at(1)
    $dot.double(var)_sub$
  } else {
    none
  }
}

消掉$m g$得

$
m acc(u) + k u + epsilon k (u^3 + 3 u_g u^2 + 3 u u_g^2) = 0
$

标准化

$
acc(u) + omega_0^2 u + epsilon omega_0^2 (u^3 + 3 u_g u^2 + 3 u u_g^2) = 0 quad omega_0 = sqrt(k/m)
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
  dot.double(u)_1 + omega^2 u_1 &= -3u_g^2 omega^2 u_0 + b_1 u_0 - 3 u_g omega^2 u_0^2 - omega^2 u_0^3,
  dot.double(u)_2 + omega^2 u_2 &= 3 u_g^2 b_1 u_0 + b_2 u_0 + 3 u_g b_1 u_0^2 + b_1 u_0^3 - 3 u_g^2 omega^2 u_1 + b_1 u_1 - 6 u_g omega^2 u_0 u_1 - 3 omega^2 u_0^2 u_1,
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
  dot.double(u)_1 + omega^2 u_1 &= -3u_g^2 omega^2 u_0 + b_1 u_0 - 3 u_g omega^2 u_0^2 - omega^2 u_0^3,
  u_1(0) &= 0,
  dot(u)_1(0) &= 0
)
$

令$cos omega t$的系数为0

$
1/4 (3 a^3 omega^2 + 12 a u_g^2 omega^2 - 4 a b_1) = 0
$

得

$
b_1 = (3 a^3 + 12 a u_g^2)/(4 a) omega^2
$

解得

$
u_1(t) = 1/32 (-48 a^2 u_g - a^3 cos omega t + 32 a^2 u_g cos omega t + 16 a^2 u_g cos 2 omega t + a^3 cos 3 omega t)
$


代入

$
cases(
  dot.double(u)_2 + omega^2 u_2 &= 3 u_g^2 b_1 u_0 + b_2 u_0 + 3 u_g b_1 u_0^2 + b_1 u_0^3 - 3 u_g^2 omega^2 u_1 + b_1 u_1 - 6 u_g omega^2 u_0 u_1 - 3 omega^2 u_0^2 u_1,
  u_2(0) &= 0,
  dot(u)_2(0) &= 0
)
$

令$cos omega t$的系数为0


$ 
- 3/64 a^5 omega^2 + 9/4 a^4 u_g omega^2 - 243/32 a^3 u_g^2 omega^2 + 3 a^2 u_g^3 omega^2 + 23/128 a^2 (-3 a^3 omega^2 - 12 a u_g^2 omega^2) \
+ 1/4 a u_g (-3 a^3 omega^2 - 12 a u_g^2 omega^2) + 3/4 u_g^2 (-3 a^3 omega^2 - 12 a u_g^2 omega^2) - a b_2 = 0
$

解得

$
b_2 = -(75 a^5 omega^2 - 192 a^4 u_g omega^2 + 1536 a^3 u_g^2 omega^2 + 1152 a u_g^4 omega^2)/(128 a)
$

解得方程为

$
u_2(t) = 1/1024 (2016 a^4 u_g - 3072 a^3 u_g^2 + 4608 a^2 u_g^3 + 23 a^5 cos omega t - 1120 a^4 u_g cos omega t \
+ 1952 a^3 u_g^2 cos omega t - 3072 a^2 u_g^3 cos omega t - 1024 a^4 u_g cos 2 omega t \
+ 1024 a^3 u_g^2 cos 2 omega t - 1536 a^2 u_g^3 cos 2 omega t - 24 a^5 cos 3 omega t + 96 a^4 u_g cos 3 omega t \
+ 96 a^3 u_g^2 cos 3 omega t + 32 a^4 u_g cos 4 omega t + a^5 cos 5 omega t)
$

可得

$
omega &= sqrt(omega_0^2 + epsilon b_1 + epsilon^2 b_2) \
&= sqrt(omega_0^2 + epsilon (3 a^3 + 12 a u_g^2)/(4 a) omega^2 + epsilon^2 (75 a^5 omega^2 - 192 a^4 u_g omega^2 + 1536 a^3 u_g^2 omega^2 + 1152 a u_g^4 omega^2)/(128 a))
$

可知, 重力大, $u_g$ 大, $omega$ 也会增大