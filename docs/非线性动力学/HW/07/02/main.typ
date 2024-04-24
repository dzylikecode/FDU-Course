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

= 题 2

#figure(image("assets/2024-04-13-16-40-32.png"))

== 解

van der Pol 系统方程

$ acc(u) + omega_0^2 = epsilon(1-u^2)u $

将周期解作有限Fourier展开

$ u= A cos omega t $

计算残值

$
R(t) &= acc(u) + omega_0^2 - epsilon(1-u^2)u \
&= - A omega^2 cos omega t + A omega_0^2 cos omega t + epsilon A omega(1- A^2 cos^2 omega t) sin omega t
$

代入 Galerkin 条件

$ integral_0^T R(t) cos omega t dif t = 0 $

可得

$ (pi A omega_0^2)/omega - pi A omega = 0 $

即

$ omega = omega_0 $

得系统的近似周期解为

$ u = A cos omega_0 t $