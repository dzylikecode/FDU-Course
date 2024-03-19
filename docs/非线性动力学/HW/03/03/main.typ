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

= 题 3

建立均质杆纵向振动的几何非线性振动方程（建模方法自由选择）

#table(
  columns: 2,
  stroke: none,
  image("assets/2024-03-18-01-08-13.png"),
  image("assets/2024-03-18-01-08-23.png")
)

根据泰勒公式, 保留应变一定的高阶项, 则有

$
epsilon = pdv(u, x)+ 1/2(pdv(u, x))^2
$

则轴向力为

$
F &= sigma S \
&= E epsilon S \
&= E S [pdv(u, x)+ 1/2(pdv(u, x))^2] \
$

由达朗贝尔原理可知

$
rho S dif x pdv(u, t, 2) = (F + pdv(F, x) dif x) - F + p(x, t)
$

代入可得

$
rho S pdv(u, t, 2) = E S pdv(u, x, 2) (1 + pdv(u, x)) + p(x, t)
$

存在$E S pdv(u, x, 2) pdv(u, x)$项, 为非线性项, 故为非线性方程