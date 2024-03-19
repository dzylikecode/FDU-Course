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

= 题 1

利用行波法（参看数理方程）求解波动方程的解

$
cases(
  pdv(u, t, 2) - a^2 pdv(u, x, 2) &= 0 quad & x in bb(R)\, t > 0,
  u(x, 0) &= phi(x),
  u_t (x, 0) &= psi(x)
)
$<ques>

== 解

令

#let xiSubs = $x + a t$
#let etaSubs = $x - a t$

$
cases(
  xi = xiSubs,
  eta = etaSubs
)
#place(dx: 20pt, dy:-20pt, stickybox(width: 5.5cm, [
#set text(size: 8pt)
- 物理含义: $u = f(xi) + f(eta)$ \
  波可以分解为两个方向
#set text(size: 7pt)
- @ques $arrow.l.r.double (pdv("", t)+a pdv("",x))(pdv("", t)- a pdv("",x)) u= 0$ \
  猜想@simple-ques
]))
$

则

#let dudx = $pdv(u, xi) + pdv(u, eta)$

$
pdv(u, x) &= pdv(u, xi) pdv(xi, x) + pdv(u, eta) pdv(eta, x) \
&= dudx
$ <lab-dudx>

进而有

$
pdv(u, x, 2) &= pdv("", x)(pdv(u, x)) \
&= pdv("", x)(dudx) \
&= pdv("", x)(pdv(u, xi)) + pdv("", x) (pdv(u, eta)) \
&= [pdv("", xi)(pdv(u, xi)) + pdv("", eta)(pdv(u, xi))] + [pdv("", xi)(pdv(u, eta)) + pdv("", eta)(pdv(u, eta))] \
&= pdv(u, xi, 2) + pdv(u, eta, xi) + pdv(u, xi, eta) + pdv(u, eta, 2) \
&= pdv(u, xi, 2) + 2 pdv(u, xi, eta) + pdv(u, eta, 2) 
#place(dx: 30pt, dy:-120pt, stickybox(width: 3cm, [
  #set text(size: 8pt)
  将$pdv(u, xi)$当作$u$代入@lab-dudx 
]))
$

同理可得

$
pdv(u, t, 2) = a^2 (pdv(u, xi, 2) - 2 pdv(u, xi, eta) + pdv(u, eta, 2))
$

代入方程可得

$
pdv(u, xi, eta) = 0
$<simple-ques>

可解得

$
&pdv(u, xi, eta) = 0 \
arrow.r.double & integral pdv(u, xi, eta) dif xi = integral 0 dif xi\
arrow.r.double & pdv(u, eta) = g(eta) \
arrow.r.double & integral pdv(u, eta) dif eta = integral g(eta) dif eta\
arrow.r.double & u = integral g(eta) dif eta + f(xi)\
arrow.r.double & u = F(xi) + G(eta)
$

所以有

$ u(x, t) = F(x + a t) + G(x - a t) $ <res-form>

代入初始条件则有

$
cases(
  F(x) + G(x) &= phi(x),
  a[F'(x)-G'(x)] &= psi(x)
)
$ <init>

对@init 中2式两边积分则有

$
F(x) - G(x) = 1/a integral psi(x) dif x + C
$ <solve-init>

联立 @solve-init 和 @init, 有

$
cases(
  F(x) &= 1/2 phi(x) + 1/(2a) integral psi(x) dif x + C,
  G(x) &= 1/2 phi(x) - 1/(2a) integral psi(x) dif x + C
)
$

代入到 @res-form , 有

$
u(x, t) &= F(xiSubs) + G(etaSubs)\
&=1/2 phi(xiSubs) + 1/(2a) integral_0^xiSubs psi(y) dif y + 1/2 phi(etaSubs) - 1/(2a) integral_0^etaSubs psi(y) dif y + C \
&= 1/2[phi(xiSubs) + phi(etaSubs)] + 1/(2a) integral_etaSubs^xiSubs psi(y) dif y + C
$

== References

- #link("https://zhuanlan.zhihu.com/p/412304618")[无界波动方程的定解——行波法]
- #link("https://zhuanlan.zhihu.com/p/131346770")[偏微分方程基础——特征线法/行波法/达朗贝尔法]