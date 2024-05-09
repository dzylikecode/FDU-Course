#show link: underline

#figure(image("assets/2024-04-29-09-32-56.png"))

== (1)

参考#link("https://wuli.wiki/online/ELACST.html")[广义胡克定律（弹性力学本构关系） - 小时百科]

根据单向拉伸的广义胡克定律

$
epsilon_(i i) = sigma_(i i)/E
$

再考虑其余方向的拉伸在该方向上产生的压缩现象, 即泊松现象

$
epsilon_(i i) = sigma_(i i)/E - nu epsilon_(j j) - nu epsilon_(k k)
$

而$epsilon_(i j)$的情况遵循单向剪切的广义胡克定律

$
epsilon_(i j) &= sigma_(i j)/(2 G) &= (1+mu)/E sigma_(i j)
$

所以

$
mat(
  sigma_(11);
  sigma_(22);
  sigma_(33);
  sigma_(12);
  sigma_(23);
  sigma_(31)
) = 
mat(
  C_11, C_12, C_13, 0, 0, 0;
  C_21, C_22, C_23, 0, 0, 0;
  C_31, C_32, C_33, 0, 0, 0;
  0, 0, 0, C_44, 0, 0;
  0, 0, 0, 0, C_55, 0;
  0, 0, 0, 0, 0, C_66
) 
mat(
  epsilon_(11);
  epsilon_(22);
  epsilon_(33);
  epsilon_(12);
  epsilon_(23);
  epsilon_(31)
)
$