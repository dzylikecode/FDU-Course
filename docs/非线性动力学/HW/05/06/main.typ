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

= 题 6

#figure(image("assets/2024-04-03-01-08-38.png"))

== 解

矩阵形式

$
mat(dot(x); acc(x)) + mat( omega_0^2, 0) mat(x; dot(x)) = mat(0; epsilon f(x, dot(x)))
$

令

$
cases(
  x &= a(t) cos psi,
  dot(x) &= - omega_0 a(t) sin psi,
  psi &= omega_0 t + phi(t)
)
$

可得

$
mat(dot(x); acc(x)) = mat(dot(a) cos psi - a cos psi (omega_0 + dot(phi)); -omega_0 (dot(a) sin psi + a cos psi (omega_0 + dot(phi)))) 
$

代入则有

$
mat(cos psi, -sin psi; sin psi,  cos psi) mat(dot(a); a dot(phi)) = mat(0; -epsilon/omega_0 f(x, dot(x)))
$

知$mat(cos psi, -sin psi; sin psi,  cos psi)$为旋转矩阵, 即正交矩阵, 有

$
A^(-1) = A^T
$

所以

$
mat(dot(a); a dot(phi)) &= mat(cos psi, -sin psi; sin psi,  cos psi)^(-1) mat(0; -epsilon/omega_0 f(x, dot(x))) \
&= mat(cos psi, -sin psi; sin psi,  cos psi)^(T) mat(0; -epsilon/omega_0 f(x, dot(x))) \
&= mat(cos psi, sin psi; -sin psi,  cos psi)mat(0; -epsilon/omega_0 f(x, dot(x))) \
&= mat(-epsilon/omega_0 f(x, dot(x)) sin psi; -epsilon/omega_0 f(x, dot(x)) cos psi)
$

所以

$
mat(dot(a); dot(phi)) = mat(-epsilon/omega_0 f(x, dot(x)) sin psi; -epsilon/(omega_0 a) f(x, dot(x)) cos psi)
$
