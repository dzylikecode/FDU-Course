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

= 题 4

#figure(image("assets/2024-04-02-16-43-08.png"))

变形为

$
acc(u) + omega_0^2 u = epsilon(omega_0^2 u - u^3) quad epsilon = 1
$

则有

$
cases(
  dot(a) &= -epsilon / (2 pi omega) integral_0^pi p(u, dot(u)) sin psi dif psi,
  dot(phi) &= -epsilon / (2 pi omega a) integral_0^pi p(u, dot(u)) cos psi dif psi
)
$

代入则有

$
cases(
  dot(a) &= -1 / (2 pi omega) integral_0^pi (omega_0^2 a cos psi - a_0^3 cos psi^3) sin psi dif psi = 0,
  dot(phi) &= -1 / (2 pi omega a) integral_0^pi (omega_0^2 a cos psi - a^3 cos psi^3) cos psi dif psi = -1/2 omega_0 + 3/8 a^2 / omega_0
)
$

得

$
cases(
  a &= a_0,
  phi &= -1/2 omega_0 t + 3/8 a_0^2 / omega_0 t
)
$

$ u = a_0 cos(t + 3/8 a_0^2/omega_0 t - 1/2 omega_0 t) $

由于 $epsilon = 1$, 解与自由振动频率相差较大, 所以不用平均法