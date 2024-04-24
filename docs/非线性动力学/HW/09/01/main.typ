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

#figure(image("assets/2024-04-23-14-07-31.png"))

== 解

阻尼为弱阻尼, 设

#let vmu = $overline(mu)$

$
mu_(r) = epsilon * vmu_r
$

用多尺度法, 设

$
cases(
  u_1 &= epsilon u_11 + epsilon^2 u_12,
  u_2 &= epsilon u_21 + epsilon^2 u_22,
)
$

代入原方程得

$
cases(
  D_0^2 u_11 + omega^2 u_11 &= 0,
  D_0^2 u_21 + omega^2 u_21 &= 0,
)
$ <eq-1>

$
cases(
  D_0^2 u_12 + omega^2 u_12 &= - 2 D_0 D_1 u_11 - 2 vmu_1 D_0 u_11 - a_11 u_11^2 - a_12 u_11 u_21 - a_13 u_21^2,
  D_0^2 u_22 + omega^2 u_22 &= - 2 D_0 D_1 u_21 - 2 vmu_2 D_0 u_21 - a_21 u_11^2 - a_22 u_11 u_21 - a_23 u_21^2,
)
$ <eq-2>

解得 @eq-1

$
cases(
  u_11 &= A_1 e^(i omega T_0) + "cc",
  u_21 &= A_2 e^(i omega T_0) + "cc",
)
$

代入 @eq-2 得

$
cases(
  D_0^2 u_12 + omega^2 u_12 &= (- 2 i omega D_1 A_1 - 2 vmu_1 i omega A_1)e^(i omega T_0) - (a_11 A_1^2 + a_12 A_1 A_2 + a_13 A_2^2)e^(i 2 omega T_0) \
  &quad - (a_11 A_1 overline(A)_1 + a_12 A_1 overline(A)_2 + a_13 A_2 overline(A)_2) + "cc",
  D_0^2 u_22 + omega^2 u_22 &= (- 2 i omega D_1 A_2 - 2 vmu_2 i omega A_2)e^(i omega T_0) - (a_21 A_1^2 + a_22 A_1 A_2 + a_23 A_2^2)e^(i 2 omega T_0) \
  &quad - (a_21 A_1 overline(A)_1 + a_22 A_1 overline(A)_2 + a_23 A_2 overline(A)_2) + "cc",
)
$

消除永年项

$
D_1 A_r + vmu_r A_r = 0
$

所以

$
A_r = a_r e^(-vmu_r T_1)
$

即

$
u_r &= epsilon A_r e^(i omega T_0) + "cc" \
&= epsilon a_r e^(- vmu_r epsilon t) cos (omega t + phi_r)
$
