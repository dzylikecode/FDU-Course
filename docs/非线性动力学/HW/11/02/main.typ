#figure(image("assets/2024-05-08-17-01-59.png"))

== 解

特征方程

$
lambda^2 + b lambda + k = 0
$

解得

$
lambda = (-b plus.minus sqrt(b^2 - 4 k)) / 2
$

分类讨论

#align(
  center,
  table(
    columns: 3,
    stroke: none,
    $b^2-4k > 0, k > 0, b > 0$,
    [
      $lambda_1, lambda_2$为负实数
    ],
    [
      稳定结点
    ],
    $b^2-4k > 0, k > 0, b < 0$,
    [
      $lambda_1, lambda_2$为正实数
    ],
    [
      不稳定结点
    ],
    $b^2-4k > 0, b = 0, k>0$,
    [
      $lambda_1, lambda_2$纯虚数
    ],
    [
      中心
    ],
    $b^2-4k > 0, k < 0$,
    [
      $lambda_1, lambda_2$异号
    ],
    [
      鞍点
    ],
    $b^2-4k < 0, b > 0$,
    [
      $lambda_1, lambda_2$为负实部复数
    ],
    [
      稳定焦点
    ],
    $b^2-4k < 0, b < 0$,
    [
      $lambda_1, lambda_2$为正实部复数
    ],
    [
      不稳定焦点
    ],
  )
)

分布如图

#figure(image("figure/region.png"))
