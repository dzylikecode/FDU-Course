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

= 题 1

求解问题 7

#figure(image("assets/2024-04-08-16-21-27.png"))

#figure(image("assets/2024-04-08-16-15-39.png"))

== 解

变形原方程为

$ acc(u)(t) + omega_0^2 u = - epsilon N sgn dot(u)(t) quad epsilon = mu $

为求解一次近似解, 需要用两个时间尺度$T_0$, $T_1$

代入方程

$
cases(
D_0^2 u_0 + omega_0^2 u_0 &= 0,
D_0^2 u_1 + omega_0^2 u_0 &= - 2 D_0 D_1 u_0 + p(u_0, D_0 u_0)
)
$

得

$
cases(
D_0^2 u_0 + omega_0^2 u_0 &= 0,
D_0^2 u_1 + omega_0^2 u_0 &= - 2 D_0 D_1 u_0 - N sgn(D_0 u_0)
)
$

解

$ D_0^2 u_0 + omega_0^2 u_0 &= 0 $

为

$
u_0 = a(T_1) cos(omega_0 T_0 + phi(T_1))
$

应用Euler公式写出复数形式

$
u_0 = A(T_1) e^(j omega_0 T_0) + "cc" quad "cc代表共轭项"
$

其中, $A = (a e^(j phi))/2$

代入

$ D_0^2 u_1 + omega_0^2 u_0 &= - 2 D_0 D_1 u_0 - N sgn(D_0 u_0) $

计算

$
D_0 D_1 u_0 &= D_1 D_0 u_0 \
&= D_1 D_0 (A(T_1) e^(j omega_0 T_0) + "cc") \
&= D_1 D_0 A(T_1) e^(j omega_0 T_0) + D_1 D_0 "cc" \
&= j omega_0 e^(j omega_0 T_0) D_1  A(T_1)  + "cc" quad "cc 会随着变动, 保证实数"\
$

$
D_0 u_0 = &= D_0 (a(T_1) cos(omega_0 T_0 + phi(T_1))) \
&= omega_0 a cos psi
$

所以

$
D_0^2 u_1 + omega_0^2 u_0 &= - 2 j omega_0 e^(j omega_0 T_0) D_1  A(T_1)  - N sgn(omega_0 a cos psi) \
$

为消除永年项, 要求不能含有$e^(plus.minus j omega_0 T_0)$

则有

$
cases(
  D_1 a &= - 1/(2 pi omega_0) integral_0^(2 pi) p(a cos psi, - omega_0 a sin psi) sin psi dif psi \
  &= N/(2 pi omega_0) integral_0^(2 pi) sgn(- omega_0 a sin psi) sin psi dif psi\
  &= - (2 N)/ (omega_0 pi) sgn(a omega_0)
  ,
  D_1 phi &= - 1/(2 pi omega_0 a) integral_0^(2 pi) p(a cos psi, - omega_0 a sin psi) cos psi dif psi \
  &= N/(2 pi omega_0 a) integral_0^(2 pi) sgn(- omega_0 a sin psi) cos psi dif psi\
  &= 0
  ,
)
$

所以

$
cases(
  a &= - (2 N)/ (omega_0 pi) sgn(a omega_0) T_1 + a_0 \
  phi &= phi_0
)
$

所以

$
u &= (- (2 N)/ (omega_0 pi) sgn(a omega_0) T_1 + a_0) cos (omega_0 T_0 + phi_0) \
&= (- (2 N)/ (omega_0 pi) sgn(a omega_0) epsilon t + a_0) cos (omega_0 t + phi_0) 
$