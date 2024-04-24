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

#figure(image("assets/2024-04-23-14-09-31.png"))

= 解

由微小假设

#let vmu = $overline(mu)$
#let va  = $overline(a)$
#let vb  = $overline(b)$

$
mu_r &= vmu_r \
a_r  &= va_r \
b_r  &= vb_r
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
  D_0^2 u_11 + omega_1^2 u_11 &= 0,
  D_0^2 u_21 + omega_2^2 u_21 &= 0,
)
$ <eq-31>

$
cases(
  D_0^2 u_12 + omega_1^2 u_12 &= - 2 D_0 D_1 u_11 - 2 vmu_1 D_0 u_11 - va_11 u_11^3 - va_12 u_11^2 u_21 - va_14 u_21^3 \
  &quad -(vb_11 u_11 + vb_12 u_21)e^(i omega T_0) + "cc",
  D_0^2 u_22 + omega_2^2 u_22 &= - 2 D_0 D_1 u_21 - 2 vmu_2 D_0 u_21 - va_21 u_11^3 - va_22 u_11^2 u_21 - va_24 u_21^3 \
  &quad -(vb_21 u_11 + vb_22 u_21)e^(i omega T_0) + "cc",
)
$ <eq-32>

解得 @eq-31

$
cases(
  u_11 &= A_1 e^(i omega_1 T_0) + "cc",
  u_21 &= A_2 e^(i omega_2 T_0) + "cc",
)
$

代入 @eq-32 得

$
cases(
  D_0^2 u_12 + omega^2 u_12 &= (- 2 i omega D_1 A_1 - 2 vmu_1 i omega_1 A_1 - 3 va_11 A_1^2 overline(A)_1 - 2 va_13 A_1 A_2 overline(A)_2)e^(i omega_1 T_0) \
  &quad - (2 va_12 A_1 overline(A)_1 A_2 + 3 va_14 A_2^2 overline(A)_2) e^(i omega_2 T_0) - va_11 A_1^3 i omega_1 e^(i 3 omega_1 T_0) \
  &quad- va_12 A_1^2 A_2 e^(i (2 omega_1 + omega_2)T_0) - va_12 overline(A)_1^2 A_2 e^(i ( omega_2 - 2 omega_1)T_0) - va_13 A_1 A_2^2 e^(i(omega_1 + 2 omega_2) T_0) \
  &quad - va_13 A_1 overline(A)_2^2 e^(i (omega_1 - 2 omega_2)T_0) - va_14 A_2^3 e^(i 3 omega_2 T_0) \
  &quad - sum_(r=1)^3 vb_(1r) A_r (e^(i (omega_r + omega)T_0) + e^(i (omega_r - omega) T_0))+ "cc",
  D_0^2 u_22 + omega^2 u_22 &= (- 2 i omega D_1 A_2 - 2 vmu_2 i omega_2 A_2 - 3 va_21 A_2^2 overline(A)_2 - 2 va_23 A_1 A_2 overline(A)_1)e^(i omega_2 T_0) \
  &quad - (2 va_22 A_2 overline(A)_2 A_1 + 3 va_24 A_1^2 overline(A)_1) e^(i omega_1 T_0) - va_21 A_2^3 i omega_2 e^(i 3 omega_2 T_0) \
  &quad- va_22 A_2^2 A_1 e^(i (2 omega_2 + omega_1)T_0) - va_22 overline(A)_2^2 A_1 e^(i ( omega_1 - 2 omega_2)T_0) - va_23 A_2 A_1^2 e^(i(omega_2 + 2 omega_1) T_0) \
  &quad - va_23 A_2 overline(A)_1^2 e^(i (omega_2 - 2 omega_1)T_0) - va_24 A_1^3 e^(i 3 omega_1 T_0) \
  &quad - sum_(r=1)^3 vb_(2r) A_r (e^(i (omega_r + omega)T_0) + e^(i (omega_r - omega) T_0))+ "cc",
)
$

由题意可知$omega_2 approx 3 omega_1$, 可设

$
omega_2 = 3 omega_1 + epsilon sigma
$

== (1)

当$omega approx 2omega_1$, 可设

$
omega = 2 omega_1 + epsilon sigma_1
$

消除永年项

$
cases(
  - 2i omega_1 D_1 A_1 - 2 vmu_1 i omega_1 A_1 - 3 va_11 A_1^2 overline(A)_1 - 2 va_13 A_1 A_2 overline(A)_2 &- va_12 overline(A)_1^2 A_2 e^(i sigma T_1) - vb_11 overline(A)_1 e^(i sigma T_1) \
  &- vb_12 A_2 e^(i (sigma - sigma_1) T_1) =0,
  - 2i omega_1 D_1 A_2 - 2 vmu_2 i omega_2 A_2 - 3 va_24 A_2^2 overline(A)_2 - 2 va_22 A_1  overline(A)_1 A_2 &- va_21 A_1^3 e^(i sigma T_1) - vb_21 A_1 e^(i sigma_1 T_1) = 0,
)
$

可以解得$A_1, A_2$, 有近似解

$
cases(
  u_1 &= A_1 e^(i omega_1 T_0) + "cc",
  u_2 &= A_2 e^(i omega_2 T_0) + "cc",
)
$

== (2)

当$omega approx 2omega_2$, 可设

$
omega = 2 omega_2 + epsilon sigma_2 = 6 omega_1 + 2 epsilon sigma + epsilon sigma_2
$

消除永年项

$
cases(
  - 2i omega_1 D_1 A_1 - 2 vmu_1 i omega_1 A_1 - 3 va_11 A_1^2 overline(A)_1 - 2 va_13 A_1 A_2 overline(A)_2 &- va_12 overline(A)_1^2 A_2 e^(i sigma T_1) =0,
  - 2i omega_1 D_1 A_2 - 2 vmu_2 i omega_2 A_2 - 3 va_24 A_2^2 overline(A)_2 - 2 va_22 A_1  overline(A)_1 A_2 &- va_21 A_1^3 e^(-i sigma T_1) \
  &- vb_22 overline(A)_2 e^(i sigma_2 T_1) = 0,
)
$

可以解得$A_1, A_2$, 有近似解

$
cases(
  u_1 &= A_1 e^(i omega_1 T_0) + "cc",
  u_2 &= A_2 e^(i omega_2 T_0) + "cc",
)
$

== (3)

当$omega approx omega_1 + omega_2$, 可设

$
omega = omega_1 + omega_2  + epsilon sigma_3
$

消除永年项

$
cases(
  - 2i omega_1 D_1 A_1 - 2 vmu_1 i omega_1 A_1 - 3 va_11 A_1^2 overline(A)_1 - 2 va_13 A_1 A_2 overline(A)_2 &- va_12 overline(A)_1^2 A_2 e^(i sigma T_1) - vb_22 overline(A)_1 e^(i sigma_3 T_1) = 0,
  - 2i omega_1 D_1 A_2 - 2 vmu_2 i omega_2 A_2 - 3 va_24 A_2^2 overline(A)_2 - 2 va_22 A_1  overline(A)_1 A_2 &- va_21 A_1^3 e^(i sigma T_1) - vb_21 A_1 e^(i sigma_3 T_1) = 0,
)
$

可以解得$A_1, A_2$, 有近似解

$
cases(
  u_1 &= A_1 e^(i omega_1 T_0) + "cc",
  u_2 &= A_2 e^(i omega_2 T_0) + "cc",
)
$