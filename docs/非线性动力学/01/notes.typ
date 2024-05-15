#import "@preview/colorful-boxes:1.2.0": *

#let acc(var) = $dot.double(var)$
#let vel(var) = $dot(var)$

如何描述各个质量之间的相互耦合效应? -> 多自由度系统和动力学方程

矩阵一般是实对称的, 实际上表达了力的作用是相互的

可以单独使用牛顿定律分析

$
M acc(X) + K X = F(t)
$

可以抽象地描述力, 扭矩等的作用, 因此可以抽象地看待, 广义地描述

=== 特殊的计算方法

考虑$acc(X) = 0$, 则有

$
K X = F(t)
$

考虑状态$X$依次为$e_1, e_2, dots, e_n$, 则有

$
K E = F(t)
$

即

$
K = F(t)
$

此时关注输入$F(t)$即可, 转化为一个静力学问题, 可求出$K$

#place(
  dx: 350pt, dy: -90pt,
  stickybox(width: 3.5cm, [
    #set text(size: 8pt)
    和给一个脉冲得到传递函数的想法一致
  ])
)

同理再考虑$X = 0$, 对$acc(X)$做同样的处理得到$M$(通过达朗贝尔原理)

最后线性叠加

#place(
  dx: 350pt, dy: -30pt,
  stickybox(width: 3.5cm, [
    #set text(size: 8pt)
    可以看到充分利用线性的特点
  ])
)

力的分析里面还是有很多细节的, 待会儿总结, 一些值得注意的要点如下:

- $theta_2$表达的是相对物体1的角度, 但是在计算时, 通常是用绝对角度, 也就是$theta_2 + theta_1$来思考