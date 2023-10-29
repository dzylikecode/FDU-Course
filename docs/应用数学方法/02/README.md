# 离散时间演化动力学 -- 差分方程

## 一维离散动力系统的基本概念

$$x, f(x), f^2(x), \cdots$$

点的状态不断映射的变化过程

- 初值
- 映射

### 微积分与拓扑学的一些预备知识

记号:

- $R$: 实数集
- $I/J$: $R$中(闭)区间
- $f: R \to R$: 一元函数
- $f^{(r)}(x)$: $f$的$r$阶导数
- $f$在$I$上是$C^r$类的指$f^{(r)}$在$I$上连续
- $C^{\infty}$: 所有阶数的导数都存在 -> 充分光滑

定义:

- [单射](https://en.wikipedia.org/wiki/Injective_function), $x \neq y \Rightarrow f(x) \neq f(y)$

  eg. 连续的单的实函数 $\to$ 单调连续函数

  若$f:I \to J$, 则$f^{-1}: J \to I$存在

- 满射 $f: I \to J$, $\forall y \in J, \exists x \in I, f(x) = y$
- 同胚, $f$是双射且$f, f^{-1}$都连续

  eg. $\tan (x)$是$(-\pi/2, \pi/2)$到$R$的同胚

- $C^r$-微分同胚, $f$是$C^r$类的双射, $f, f^{-1}$都是$C^r$类的

  eg. $f(x) = x^3$不是$C^{\infty}$-微分同胚; $\tan (x) \in C^{\infty}$-微分同胚

- 复合函数, $f: I \to J, g: J \to K$, 则$g \circ f: I \to K$

  eg. $f^n(x) = f(f^{n-1}(x))$, $f^{-n}(x) = f^{-1}(f^{-n+1}(x))$

  有以下结果:

  - 链式法则

    $$
    (f \circ g)^{\prime}(x) = f^{\prime}(g(x)) g^{\prime}(x)
    $$

  - 中值定理
  - [介值定理](https://en.wikipedia.org/wiki/Intermediate_value_theorem)

    事实上, 由于闭区间有最大和最小值, 所以针对最大值和最小值也成立

  - [函数的不动点定理](https://en.wikipedia.org/wiki/Fixed-point_theorem): $f: I \to I$是连续的, 则$\exists x \in I, f(x) = x$

    证明: 令$g(x) = f(x) - x$,

    由于$f(a), f(b) \in I$, 则不妨设$f(a) > a, f(b) < b$(相等, 则已经为不动点)

    由介值定理, $\exists x \in I, g(x) = 0$

  - Brower 不动点定理: $f: I \to I$是连续的, 且$|f^{\prime}(x)|<1$, 则在$I$中存在唯一的一个不动点, 且有$|f(x)-f(y)|<|x-y|$

    唯一性和压缩性都可以用中值定理证明

eg. 设$S \subset R$, 若存在点列$x_n \in S$收敛于$x$, 称$x$为$S$的极限点

若$S$的包含所有极限点, 则称$S$为闭集

- 有限个闭集的并是闭集, 闭集的无限并不一定是闭集

  eg. 令$I_n = [1/n, 1-1/n]$, 则$\bigcup_{n=1}^{\infty} I_n = (0, 1)$

- 有限个开集的交是闭集, 开集的无限交一定是闭集

- 令$S \subset R$, 若$\forall x \in S, \exists \delta > 0$, 使$(x-\delta, x+\delta) \subset S$, 则称$S$为开集

  - 闭集的补集是开集, 反之亦然
  - 开集的无限并是开集
  - 开集的无限交不必是开集

    eg. 令$I_n = (-1/n, 1/n)$, 则$\bigcap_{n=1}^{\infty} I_n = \{0\}$

- 对任意集合$S$, $S$的所有点和全部极限点组成$S$的闭包, 记为$\bar{S}$

  若$S$为闭集, 则$\bar{S} = S$

- 若$U$是$S$的子集, 且$\bar{U} = S$, 则称$U$在$S$中稠密

  任何开集在其闭包中稠密

### 动力系统的一些基本概念

- 以下的集合称为$x$的前向轨道, 记为$O^+(x)$

  $x, f(x), f^2(x), \cdots$

  若$f$是同胚, $x, f^{-1}(x), f^{-2}(x), \cdots$称为$x$的后向轨道, 记为$O^-(x)$

  点$f^n(x) (n \in Z)$的集合称为$x$的全轨道, 记为$O(x)$

- 若$f(x) = x$, 则称$x$为不动点

  若$f^n(x) = x$, 则称$x$为周期点, 周期为$n$, 最小正$n$称为真周期

  记$\text{Per}_n(f)$为周期为$n$的点的集合, 记$\text{Fix}(f)$为不动点的集合

  周期为$n$的周期轨道为:

  $$\cdots, x, f(x), \cdots, f^{n-1}(x), x, f(x), \cdots$$

  恒等映射: $Id(x) = x$, 使$R$上的所有点都是不动点

  $f(x)=-x$, $0$为不动点, 非零点为周期为$2$的周期点
