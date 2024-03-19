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

= 题 2

利用微元法建立均质铁摩辛科（Timoshienko）梁无外激的线性自由振动线性方程

== 解

考虑一般形式

#figure(image("assets/2024-03-17-19-03-03.png"))

=== slope of center line

#table(
  columns: 2,
  stroke: none,
  align: (center + horizon, center + horizon),
image("assets/2024-03-17-19-03-43.png", width: 80%),
[
  形变为弯矩和剪力的叠加

  $ pdv(w, x) = gamma + phi $ <CL>
]
)


=== displacements

$
u_x (x, y, z, t) &= - z phi(x, t) \
u_y (x, y, z, t) &= 0 \
u_z (x, y, z, t) &= w(x, t)
$

where $u_x, u_y, u_z$ are the components of the displacement vector in the three coordinate directions

=== strain

由 #link("https://en.wikipedia.org/wiki/Infinitesimal_strain_theory")[Infinitesimal strain theory] 知

#let strainTensor(varI, varJ) = $1/2(u_(varI, varJ) + u_(varJ, varI))$

$ 
epsilon_(i j) = strainTensor(i, j) 
#place(dx: 30pt, dy:-15pt, stickybox(width: 2cm, [
  #set text(size: 8pt)
  $u_(i, j) = pdv(u_i, j)$
]))
$

可得

$
epsilon_(x x) &= strainTensor(x, x) \
&= u_(x, x) = pdv(u_x, x) \
&= - z pdv(phi, x)
$<strain-xx>

$
epsilon_(x z) &= strainTensor(x, z) = 1/2(pdv(u_x, z) + pdv(u_z, z)) \
&= 1/2(- phi + pdv(w, x)) \
&= 1/2 gamma
#place(dx: 70pt, dy:-45pt, stickybox(width: 2cm, [
  #set text(size: 8pt)
  依据 @CL
]))
$<strain-xz>

同理

$
epsilon_(y y) &= 0 \
epsilon_(z z) &= 0 \
epsilon_(y z) &= 0 \
epsilon_(x y) &= 0 \
$<strain-rest>

由 #link("https://en.wikipedia.org/wiki/Hooke%27s_law")[Hooke's law]:

$
sigma_(x x) &= E epsilon_(x x)
#place(dx: 10pt, dy:-15pt, stickybox(width: 2.5cm, [
  #set text(size: 8pt)
  泊松比$nu = 0$
]))
$ <tensor-xx>

$x z$为角度变形, 设剪切系数为$k$, 则

$
sigma_(x z) &= G gamma(x z) \
&= k G gamma(x)
$ <tensor-xz>

#place(dx: 280pt, dy:-50pt, stickybox(width: 5.5cm, [
  #set text(size: 8pt)
  - $epsilon$被称为 tensor strain

  - $gamma$被称为 engineering strain

  二者的关系由@strain-xz 联系

  Hooke's law 矩阵为 tensor strain 形式
]))

=== Hamilton

#let HT(..eq) = text(fill: rgb("#0074d9"), $#eq.pos().at(0)$)
#let HV(..eq) = text(fill: rgb("#2ecc40"), $#eq.pos().at(0)$)
#let HW(..eq) = text(fill: rgb("#ff851b"), $#eq.pos().at(0)$)

由 #link("https://en.wikipedia.org/wiki/Hamilton%27s_principle")[Hamilton's principle] 知

$
integral_(t_1)^(t_2) (HT(delta T) - HV(delta U) + HW(delta W_E)) dif t = 0
$

==== strain energy

$
HV(
  U = integral_V W dif V
)
$ <int-u>

由 #link("https://en.wikipedia.org/wiki/Strain_energy_density_function")[Strain energy density function]

$
HV(
  W = 1/2 sum sum sigma_(i j) epsilon_(i j)
)
$

代入 @strain-xx @strain-xz @strain-rest @tensor-xx @tensor-xz :

#let densityW = $1/2 E z^2 (pdv(phi, x))^2 + 1/2 k G gamma^2$

$
HV(
  W &= 1/2 sum sum sigma_(i j) epsilon_(i j) \
  &= 1/2 sigma_(x x) epsilon_(x x) + sigma_(x z) epsilon_(x z) \
  &= 1/2 E epsilon_(x x)^2 + 1/2 k G gamma^2 \
  &= densityW
)
$

所以 @int-u 变为

#let simpleI = $integral_A z^2 dif A$

$
HV(
  U &= integral_V (densityW) dif V \
  &= 1/2 integral_0^l integral_A (E z^2 (pdv(phi, x))^2 + k G gamma^2) dif A d x \
  &= 1/2 [(integral_0^l E (integral_A z^2 dif A) pdv(phi, x) dif x) + integral_0^l k G A gamma^2 dif x] \
  &= 1/2 integral_0^l E I (pdv(phi, x))^2 dif x + 1/2  integral_0^l k G A gamma^2 dif x
)
#place(dx: 60pt, dy:-60pt, stickybox(width: 2.5cm, [
  #set text(size: 8pt)
  $I=simpleI$
]))
$

代入 @CL , 可得

$
HV(
  U = 1/2 integral_0^l E I (pdv(phi, x))^2 dif x + 1/2  integral_0^l k G A (pdv(w, x) - phi)^2 dif x
)
$

故

$
HV(
  delta U &= integral_0^l E I pdv(phi, x) delta (pdv(phi, x)) dif x + integral_0^l k G A (pdv(w, x) - phi) (delta(pdv(w, x)) - delta phi)dif x \
  &= integral_0^l E I pdv(phi, x) delta (pdv(phi, x)) dif x \
  & quad quad + integral_0^l k G A (pdv(w, x) - phi) delta(pdv(w, x))dif x \
  & quad quad - integral_0^l k G A (pdv(w, x) - phi) delta phi dif x \
  &= E I pdv(phi, x) delta phi bar_0^l - integral_0^l pdv("", x)(E I pdv(phi, x)) delta phi dif x \
  & quad quad k G A (pdv(w, x) - phi) delta w bar_0^l - integral_0^l pdv("", x)[k G A (pdv(w, x) - phi)] delta w dif w \
  & quad quad - integral_0^l k G A (pdv(w, x) - phi) delta phi dif x
)
$ <eq-HV>

==== kinetic energy

translatinal kinetic energy + rotational kinetic energy

$
HT(
  T = 1/2 integral_0^l rho A (pdv(w, t))^2 dif x + 1/2 integral_0^l rho I (pdv(phi, t))^2 dif x
)
$

故

$
HT(
  delta T = integral_0^l m pdv(w, t) delta (pdv(w, t)) dif x + integral_0^l J pdv(phi, t) delta (pdv(phi, t)) dif x
)
#place(dx: 5pt, dy:-15pt, stickybox(width: 3cm, [
  #set text(size: 8pt)
  $m = rho A, J = rho I$
]))
$

则

$
HT(
  integral_(t_1)^(t_2) delta T &= integral_(t_1)^(t_2) [ integral_0^l m pdv(w, t) delta (pdv(w, t)) dif x + integral_0^l J pdv(phi, t) delta (pdv(phi, t)) dif x ] dif t\
  &= integral_0^l integral_(t_1)^(t_2) m pdv(w, t) delta (pdv(w, t)) dif t dif x + integral_0^l integral_(t_1)^(t_2) J pdv(phi, t) delta (pdv(phi, t)) dif t dif x \
  &= integral_0^l (m pdv(w, t) delta w bar_(t_1)^(t_2) - integral_(t_1)^(t_2) pdv("", t)(m pdv(w, t)) delta w dif t) dif x \
  &quad quad + integral_0^l (J pdv(phi, t) delta phi bar_(t_1)^(t_2) - integral_(t_1)^(t_2) pdv("", t)(J pdv(phi, t)) delta phi dif t) dif x \
  &= - integral_0^l integral_(t_1)^(t_2) pdv("", t)(m pdv(w, t)) delta w dif t dif x - integral_0^l integral_(t_1)^(t_2) pdv("", t)(J pdv(phi, t)) delta phi dif t dif x \
  &= - integral_(t_1)^(t_2) integral_0^l pdv("", t)(m pdv(w, t)) delta w dif x dif t - integral_(t_1)^(t_2) integral_0^l pdv("", t)(J pdv(phi, t)) delta phi dif x dif t
)
$ <eq-HT>

==== external work

$
HW(
  W_E = integral_0^l q w dif x
)
$

故

$
HW(
  delta W_E = integral_0^l q delta w dif x
)
$ <eq-HW>

==== 代入 Hamilton

由 @eq-HV @eq-HT @eq-HW 可得

$
integral_(t_1)^(t_2) (HT(delta T) - HV(delta U) + HW(delta W_E)) dif t &= 
HT(
  - integral_(t_1)^(t_2) integral_0^l pdv("", t)(m pdv(w, t)) delta w dif x dif t \
  & quad quad - integral_(t_1)^(t_2) integral_0^l pdv("", t)(J pdv(phi, t)) delta phi dif x dif t
) \
& quad quad -
HV(
  integral_(t_1)^(t_2)(E I pdv(phi, x) delta phi bar_0^l - integral_0^l pdv("", x)(E I pdv(phi, x)) delta phi dif x \
  & quad quad k G A (pdv(w, x) - phi) delta w bar_0^l - integral_0^l pdv("", x)[k G A (pdv(w, x) - phi)] delta w dif w \
  & quad quad - integral_0^l k G A (pdv(w, x) - phi) delta phi dif x) dif t
)\
& quad quad +
  HW(
    integral_(t_1)^(t_2) integral_0^l q delta w dif x dif t
  ) \
&= integral_(t_1)^(t_2) integral_0^l [(HT(- pdv("", t)(m pdv(w, t))) HV(+ pdv("", x)[k G A (pdv(w, x) - phi)]) HW(+ q)) delta w \
&quad quad (HT(- pdv("", t)(J pdv(phi, t))) HV(+ pdv("", x)(E I pdv(phi, x)) + k G A (pdv(w, x) - phi))) delta phi] dif x dif t \
&quad quad HV( - E I pdv(phi, x) delta phi bar_0^l - k G A (pdv(w, x) - phi) delta w bar_0^l)\
&= 0
$

由任意性可得

$
cases(
  HT(- pdv("", t)(m pdv(w, t))) HV(+ pdv("", x)[k G A (pdv(w, x) - phi)]) HW(+ q) &= 0,
  HT(- pdv("", t)(J pdv(phi, t))) HV(+ pdv("", x)(E I pdv(phi, x)) + k G A (pdv(w, x) - phi)) &= 0
)
$ <Dynamic-Timoshenko-beam>

边界条件为

$
cases(
  E I pdv(phi, x) delta phi bar_0^l &= 0,
  k G A (pdv(w, x) - phi) delta w bar_0^l &= 0
)
$

=== 根据均质条件

由@Dynamic-Timoshenko-beam 可得

$
- m pdv(w, t, 2) + k G A (pdv(w, x, 2) - pdv(phi, x)) + q &= 0
$ <homogeneous-1>

$
- J pdv(phi, t, 2) + E I pdv(phi, x, 2) + k G A (pdv(w, x) - phi) &= 0
$ <homogeneous-2>

现将@homogeneous-1 代入@homogeneous-2 消掉 $phi$

由 @homogeneous-1 可得

$
cases(
  pdv(phi, x) &= q/(k G A) - m /(k G A) pdv(w, t, 2) + pdv(w, x, 2),
  pdv(phi, x, 3) &= 1/(k G A) pdv(q, x, 2) - m /(k G A) pdv(w, x, t, [2, 2]) + pdv(w, x, 3) \
  pdv(phi, x, t, [1, 2]) &= 1/(k G A) pdv(q, t, 2) - m /(k G A) pdv(w, t, 4) + pdv(w, x, t, [2, 2])
)
$ <homogeneous-1-derivation>

由 @homogeneous-2 可得

$
J pdv(w, x, t, [1, 2]) = E I pdv(w, x, 3) + k G A (pdv(w, x, 2) - pdv(phi, x)) = 0
$ <homogeneous-2-derivation>

将@homogeneous-1-derivation 代入@homogeneous-2-derivation 可得

$
E I pdv(w, x, 4) + m pdv(w, t, 2) - (J + (m E I) /(k G A)) pdv(w, x, t, [2, 2]) + (m J) /(k G A) pdv(w, t, 4) = q + (J) /(k G A) pdv(q, t, 2) - (E I) /(k G A) pdv(q, x, 2)
$

由题意, 外部激励$q = 0$, 所以

$
E I pdv(w, x, 4) + m pdv(w, t, 2) - (J + (m E I) /(k G A)) pdv(w, x, t, [2, 2]) + (m J) /(k G A) pdv(w, t, 4) = 0
$

== Reference

- #link("https://www.youtube.com/playlist?list=PL2ym2L69yzkamORF9DGWRhE9qUnb0_-6H")[Structural Dynamics]: 很不错的合集 关于Timoshenko Beam的里面:
  - #link("https://www.youtube.com/watch?v=e6WhAoVGQ0c&list=PL2ym2L69yzkamORF9DGWRhE9qUnb0_-6H&index=18")[Timoshenko Beam Theory Part 2 of 3: Hamilton's Principle]
  - #link("https://www.youtube.com/watch?v=1X-NMQITQz4&list=PL2ym2L69yzkamORF9DGWRhE9qUnb0_-6H&index=19")[Timoshenko Beam Theory Part 3 of 3: Equations of Motion]
- #link("https://en.wikipedia.org/wiki/Timoshenko%E2%80%93Ehrenfest_beam_theory")[Timoshenko–Ehrenfest beam theory]
