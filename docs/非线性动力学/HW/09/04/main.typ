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

#figure(image("assets/2024-04-23-14-09-57.png"))

== 证明

令$A_2 = 0$, 则有

$
cases(
  u_11 &= A_1 e^(j omega_1 T_0) + "cc",
  u_21 &= Gamma_1 A_1 e^(j omega_1 T_0) + "cc"
)
$

代入方程组有

$
cases(
  (- omega_1^2 A_1 - c j omega_1 Gamma_1 A_1 + k_11 A_1 + k_12 Gamma_1 A_1) e^(j omega_1 T_0) &= 0,
  (- omega_1^2 Gamma_1 A_1 + c j omega_1 A_1 + k_21 A_1 + k_22 Gamma_1 A_1) e^(i omega_1 T_0) &= 0,
)
$

令$lambda = j omega_1$, 则有

$
mat(
  delim:"[",
  k_11 + lambda^2, k_12 - c lambda;
  k_21 + c lambda, k_22 + lambda^2
)
mat(
  delim:"[",
  A_1;
  Gamma_1 A_1
) = 0
$

有非零解, 则

$
mat(
  delim:"|",
  k_11 + lambda^2, k_12 - c lambda;
  k_21 + c lambda, k_22 + lambda^2
) = 0
$

同时由

$
(k_21 + c lambda) A_1 + (k_22 + lambda) Gamma_1 A_1 = 0
$

可得

$
Gamma_1 = - (k_21 + c j omega_1)/(omega_1^2 - k_22)
$

同理令$A_1 = 0$有

$
mat(
  delim:"|",
  k_11 + lambda^2, k_12 - c lambda;
  k_21 + c lambda, k_22 + lambda^2
) = 0
$

$
Gamma_2 = - (k_21 + c j omega_2)/(omega_2^2 - k_22)
$