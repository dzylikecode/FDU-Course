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

= 题 3

#figure(image("assets/2024-04-02-16-11-44.png"))

== 1

近似

$ sin u approx u - 1/ 3! u^3 $

代入则有

$
acc(u) + u = 1/6 u^3
$

令

$
cases(
  u &= a(t) cos (omega_0 t + phi(t)),
  dot(u) &= - omega_0 a(t) sin (omega_0 t + phi(t))
)
$

求导得

$
cases(
  dot(u) &= dot(a) cos (omega_0 t + phi) - a sin (omega_0 t + phi) (omega_0 + dot(phi)),
  acc(u) &= - omega_0 [dot(a) sin (omega_0 t + phi) + a cos (omega_0 t + phi) (omega_0 + dot(phi))]
)
$

则有

$
cases(
  dot(a) cos (omega_0 t + phi) - a sin (omega_0 t + phi) dot(phi) &= 0,
  dot(a) sin (omega_0 t + phi) + a cos (omega_0 t + phi) dot(phi) &= -1/omega_0 1/6 a^3 cos^3 (omega_0 t + phi),
)
$

解得

$
cases(
  dot(a) &= -1/omega_0 1/6 a^3 cos^3 (omega_0 t + phi) sin(omega_0 t + phi),
  phi(a) &= -1/omega_0 1/6 a^3 cos^3 (omega_0 t + phi) cos(omega_0 t + phi),
)
$

用平均值近似, 且由题意$omega_0 = 1$

$
cases(
  dot(a) &= - 1/(2 pi omega_0) integral_0^(2 pi) 1/6 a^3 cos^3 (omega_0 t + phi) sin(omega_0 t + phi) dif t = 0,
  phi(a) &= - 1/(2 pi omega_0 a) integral_0^(2 pi) 1/6 a^3 cos^3 (omega_0 t + phi) cos(omega_0 t + phi) dif t = 1/16 a^2,
)
$

所以

$
cases(
  a &= a_0,
  phi &= 1/16 a^2 t 
)
$

所以

$ u = a_0 cos (t + 1/16 a^2 t) $

== 2

令

$
cases(
  u &= a(t) cos (omega_0 t + phi(t)),
  dot(u) &= - omega_0 a(t) sin (omega_0 t + phi(t))
)
$

则有

$
cases(
  dot(a) &= -epsilon / (2 pi omega) integral_0^pi p(u, dot(u)) sin psi dif psi,
  dot(phi) &= -epsilon / (2 pi omega a) integral_0^pi p(u, dot(u)) cos psi dif psi
)
$


代入


$
cases(
  dot(a) &= epsilon / (2 pi) integral_0^pi (a^2 cos^3 psi + a^3 cos^3 psi) sin psi dif psi = 0,
  dot(phi) &= epsilon / (2 pi a) integral_0^pi (a^2 cos^3 psi + a^3 cos^3 psi) cos psi dif psi = 3/8 epsilon a^2
)
$

所以

$
cases(
  a &= a_0,
  phi &= 3/8 epsilon a^2 t
)
$

所以

$ u = a_0 cos (t + 3/8 epsilon a^2 t) $