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

#figure(image("assets/2024-04-23-14-09-07.png"))

== 解

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
  D_0^2 u_11 + omega_1^2 u_11 &= 0,
  D_0^2 u_21 + omega_2^2 u_21 &= 0,
)
$ <eq-21>

$
cases(
  D_0^2 u_12 + omega_1^2 u_12 &= - 2 D_0 D_1 u_11 + (1-u_11^2)D_0 u_11 + a_1 u_21,
  D_0^2 u_22 + omega_2^2 u_22 &= - 2 D_0 D_1 u_21 + (1-u_21^2)D_0 u_21 + a_2 u_11,
)
$ <eq-22>

解得 @eq-21

$
cases(
  u_11 &= A_1 e^(i omega_1 T_0) + "cc",
  u_21 &= A_2 e^(i omega_2 T_0) + "cc",
)
$

代入 @eq-22 得

$
cases(
  D_0^2 u_12 + omega^2 u_12 &= (- 2 i omega D_1 A_1 + i omega_1 A_1 - A_1^2 overline(A)_1 i omega_1)e^(i omega_1 T_0) \
  &quad - A_1^3 i omega_1 e^(i 3 omega_1 T_0) + a_1 A_2 e^(i omega_2 T_0) + "cc",
  D_0^2 u_22 + omega^2 u_22 &= (- 2 i omega D_1 A_2 + i omega_2 A_2 - A_2^2 overline(A)_2 i omega_2)e^(i omega_2 T_0) \
  &quad - A_2^3 i omega_2 e^(i 3 omega_2 T_0) + a_2 A_1 e^(i omega_1 T_0) + "cc",
)
$

知$omega_1 approx omega_2$, 可设

$
omega_1  = omega_2 + epsilon sigma
$

消除永年项

$
cases(
  - (2 D_1 A_1 - A_1 + A_1^2 overline(A)_1) i omega + a_1 A_2 e^(i sigma T_1) &= 0,
  - (2 D_1 A_2 - A_2 + A_2^2 overline(A)_2) i omega + a_2 A_1 e^(i sigma T_1) &= 0,
)
$

分离虚实部

$
cases(
  D_1 alpha_1 - alpha_1/2 + alpha_1^3/8 - (a_1 alpha_2) /(2 omega_1) sin(beta_2 - beta_1 - sigma T_1) &= 0,
  alpha_1 D_1 beta_1 + (a_1 alpha_2)/(2 omega_1) cos(beta_2 - beta_1 - sigma T_1) &= 0,
  D_1 alpha_2 - alpha_2/2 + alpha_2^3/8 - (a_2 alpha_1) /(2 omega_2) sin(beta_1 - beta_2 + sigma T_1) &= 0,
  alpha_2 D_1 beta_2 + (a_2 alpha_1)/(2 omega_2) cos(beta_1 - beta_2 + sigma T_1) &= 0,
)
$

令$phi = beta_2 - beta_1 -sigma T_1$

$
cases(
  D_1 alpha_1 &= alpha_1/2 - alpha_1^3/8 + (a_1 alpha_2)sin phi,
  D_1 alpha_2 &= alpha_2/2 - alpha_2^3/8 + (a_2 alpha_1)sin phi,
  alpha_1 alpha_2 D_1 phi &= ((a_1 alpha_2^2)/(2 omega_1) - (a_2 alpha_1^2)/(2 omega_2))cos phi - alpha_1 alpha_2 sigma,
)
$

求解三维自治方程得

$
cases(
  u_1 &= alpha_1 cos (omega_1 t + beta_1),
  u_2 &= alpha_2 cos (omega_2 t + beta_2),
)
$