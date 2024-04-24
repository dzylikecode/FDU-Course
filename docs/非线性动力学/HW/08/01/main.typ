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

= 题 1

#figure(image("assets/2024-04-17-20-33-32.png"))

== 解

考虑具有阻尼的Mathieu方程

$
acc(u) + 2 zeta dot(u) + (delta + 2 epsilon cos 2t) u = 0, abs(epsilon) lt.double 1, 0 <= zeta lt.double 1
$

=== 确定稳定性边界的条件

由Liouville公式可得

$
det B &= e^(-integral_0^T p_1(t) dif t) \
&= e^(-integral_0^T 2 zeta dif t)\
&= e^(- 2 pi zeta)
$

可得特征方程为

$
lambda^2 - (tr B) lambda + e^(- 2 pi zeta) = 0
$

解得

$
lambda_(1, 2) = (tr B)/2 plus.minus sqrt(((tr B)/2)^2 - e^(- 2 pi zeta))
$

由 Floquet定理推论, 方程零件稳定的临界条件为三者之一:

$
abs(lambda_1) = 1, abs(lambda_2) < 1\
abs(lambda_1) < 1, abs(lambda_2) = 1\
abs(lambda_1) = abs(lambda_2) = 1
$

注意到

$ lambda_1 lambda_2 = e^(- 2pi zeta) < 1 $

所以条件3不成立

而根据前两个条件知, 根不可能为复数根, 因为这是实数方程, 复数根必然共轭, 模长相同

由此可得

- 情况 1:

  $ lambda_1 = (tr B)/2 + sqrt(((tr B)/2)^2 - e^(- 2 pi zeta)) = 1, lambda_2 = (tr B)/2 - sqrt(((tr B)/2)^2 - e^(- 2 pi zeta)) < 1 $

  此时

  $
  tr B = 1 + e^(- 2 pi zeta)
  $

  方程有一个以$pi$为周期的正规解, 另一个正规解渐近稳定. 受扰零解趋于以$pi$为周期的正规解

- 情况 2:

  $ lambda_1 = (tr B)/2 + sqrt(((tr B)/2)^2 - e^(- 2 pi zeta)) > -1, lambda_2 = (tr B)/2 - sqrt(((tr B)/2)^2 - e^(- 2 pi zeta)) = -1 $

  此时

  $
  tr B = - (1 + e^(- 2 pi zeta))
  $

  方程有一个以$2pi$为周期的正规解, 另一个正规解渐近稳定. 受扰零解趋于以$2pi$为周期的正规解

=== 稳定性边界的确定

设阻尼为

$ zeta = epsilon mu $

由摄动法

$
cases(
  u(t) &= u_0(t) + epsilon u_1(t) + epsilon^2 u_2(t) + dots.c \
  delta(t) &= delta_0 + epsilon delta_1 + epsilon^2 delta_2 + dots.c \
)
$ <expansion>

代入方程得

$
acc(u, 0) + delta_0 u_0 &= 0
$<eq-1>

$
acc(u, 1) + delta_0 u_1 &= -(delta_1 + 2 cos 2 t)u_0 - 2 mu dot(u)_0
$<eq-2>

$
acc(u, 2) + delta_0 u_2 &= -delta_2 u_0 -(delta_1 + 2 cos 2 t)u_1 - 2 mu dot(u)_1
$<eq-3>

解得 @eq-1 为

$
u_0 = a cos sqrt(delta_0)t + b sin sqrt(delta_0)t
$ <sol-1>

其中

$ delta_0 = n^2, n = 0, 1, 2, dots.c $

==== $delta_0 = 0$

则@sol-1 为

$ u_0 = a = "const" $

代入@eq-2 得

$
acc(u, 1) = - a(delta_1 + 2 cos 2 t)
$

消除永年项

$ delta_1 = 0 $

解得

$
u_1 = a/2 cos 2 t
$

代入 @eq-3

$
acc(u, 2) = -a(delta_2 + 1/2) + 2 mu a sin 2 t - a/2 cos 4 t
$

消除永年项

$
delta_2 = - 1/2
$

解得

$
u_2 = - (mu a)/2 sin 2 t + a /32 cos 4 t
$

代入 @expansion, 可得$delta_0 = 0$附近的稳定边界

$
delta = - epsilon^2/2 + O(epsilon^2)
$

==== $delta_0 = 1$

则@sol-1 为

$ u_0 = a cos t + b sin t $

代入@eq-2 得

$
acc(u, 1) + u_1 = -[(delta_1 + 1)a + 2 mu b] cos t + [2 mu a - (delta_1 - 1)b]sin t - a cos 3t - b sin 3t
$

消除永年项

$
cases(
  (delta_1 + 1)a + 2 mu b &= 0,
  2 mu a - (delta_1 - 1)b &= 0
)
$

即

$
delta_1 = plus.minus sqrt(1-4mu^2) quad abs(mu) < 1/2
$

解得

$
u_1 = 1/8(a cos 3t + b sin 3t)
$

代入 @eq-3

$
acc(u, 2) + u_2 = -(delta_2 + 1/8)(a cos t + b sin t) - ((delta_1 a)/8+(3 mu b)/4) cos 3t \
+ ((3 mu a)/4 - (delta_1 b)/8)sin 3t - a/8 cos 5t- b/8 sin 5t
$

消除永年项

$
delta_2 = - 1/8
$

解得

$
u_2 = 1/64 [(delta_1a+ 6 mu a)cos 3t+(delta_1 b - 6 mu a)sin 3t]+1/192 (a cos 5t + b sin 5t)
$

代入 @expansion, 可得$delta_0 = 1$附近的稳定边界

$
delta = 1 plus.minus sqrt(epsilon^2 - 4 zeta^2) - 1/8 epsilon^2 + O(epsilon^3)
$

==== $delta_0 = 4$

则@sol-1 为

$ u_0 = a cos 2t + b sin 2t $

代入@eq-2 得

$
acc(u, 1) + u_1 = -a-(delta_1 a + 4 mu b) cos 2t + (4 mu a - delta_1b)sin 2t - a cos 4t - b sin 4t
$

消除永年项

$
cases(
  delta_1 a + 4 mu b &= 0,
  4 mu a - delta_1b &= 0
)
$

即

$
cases(
  delta_1 &= 0,
  mu &= 0
)
$

说明$O(epsilon)$量级的阻尼过大, 需要用更小的阻尼

$ zeta = epsilon^2 hat(mu) $

此时

$
acc(u, 0) + delta_0 u_0 &= 0
$<eq-1-fix>

$
acc(u, 1) + delta_0 u_1 &= -(delta_1 + 2 cos 2 t)u_0
$<eq-2-fix>

$
acc(u, 2) + delta_0 u_2 &= - delta_2 u_0 -(delta_1 + 2 cos 2 t)u_1 - 2 hat(mu) dot(u)_0
$<eq-3-fix>

重新将解代入 @eq-2-fix 得

$
acc(u, 1) + u_1 = -a-delta_1(a cos 2t + b sin 2t) - a cos 4t - b sin 4t
$

消除永年项

$
delta_1 = 0
$

解得

$
u_1 = - a/4 + a/12 cos 4t + b/12 sin 4t
$

代入 @eq-3-fix

$
acc(u, 2) + u_2 = - [(delta_2 - 5/12)a+ 4 hat(mu) a]cos 2t+[4 hat(mu) a - (delta_2 + 1/12)b]sin 2t \
- a/12 cos 6t- b/12 sin 6t
$

消除永年项

$
cases(
  (delta_2 - 5/12)a+ 4 hat(mu) a &= 0,
  4 hat(mu) a - (delta_2 + 1/12)b &= 0
)
$

非零解条件为

$
delta_2^2 - 1/3 delta_2 - (5/144 - 16 hat(mu)^2) = 0
$

可得

$
delta_2 = 1/6 plus.minus sqrt(1/16 - 16 hat(mu)^2)
$

此时, 解得

$
u_2 = 1/384 (a cos 6t + b sin 6t)
$

代入 @expansion, 可得$delta_0 = 4$附近的稳定边界

$
delta = 4 + epsilon^2 / 6 plus.minus sqrt(epsilon^4/16 - 16 zeta^2)+ O(epsilon^3)
$

== 作图

#table(
  columns: 2,
  stroke: none,
  image("figure/fig-1.png"),
  image("figure/fig-2.png"),
)