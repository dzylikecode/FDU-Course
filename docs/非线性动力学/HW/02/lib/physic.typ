#let lagOne = [第一类拉格朗日方程]
#let acc(var, sub) = [$dot.double(var)_sub$]
#let lagEqOne = [
  $
  cases(
    F_"ix" - m_i acc(x, i) + sum_(j=0)^r lambda_j (diff f_j)/(diff x_i)= 0,
    F_"iy" - m_i acc(y, i) + sum_(j=0)^r lambda_j (diff f_j)/(diff y_i)= 0,
    (i = 1, 2, dots, n)
  )
  $
]

#let routh = [罗斯方程]
#let routhEq = $
  Q_j - d / (d t)((diff L)/(diff dot(q)_i)) + (diff L)/(diff q_i) + sum_(i = 1)^(r+s)lambda_i B_(i j) = 0 quad j = 1, 2, dots, n
$