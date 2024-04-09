
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

= 题 5

#figure(image("assets/2024-04-02-16-43-42.png"))

变形为

$
acc(u) + omega_0^2 u = - epsilon N sgn dot(u) quad epsilon = mu
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
  dot(a) &= epsilon / (2 pi omega) integral_0^pi (N sgn (- omega_0 a sin psi)) sin psi dif psi = - (2 epsilon N) / (pi omega_0) sgn a,
  dot(phi) &= epsilon / (2 pi omega a) integral_0^pi (N sgn (- omega_0 a sin psi)) cos psi dif psi = 0
)
$

得

$
cases(
  a &= a_0 - (2 epsilon N) / (pi omega_0) sgn(a) t,
  phi &= 0
)
$

所以

$
u = (a_0 - (2 mu N) / (pi omega_0) sgn(a) t) cos omega_0 t
$