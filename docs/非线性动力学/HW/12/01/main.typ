= 题 1

#image("assets/2024-05-09-17-50-31.png")

#image("assets/2024-05-09-17-50-44.png")

#image("assets/2024-05-09-22-25-22.png")

== 4.f

=== Draw phase portraits

#table(
  columns: 2,
  stroke: none,
  image("figure/4-f-p01.png"),
  image("figure/4-f-n01.png"),
)

===  Compute the one-parameter family of center manifolds and describe the dynamics on the center manifolds

Jacobian Matrix at fixed point:

$
J = mat(
  delim:"[",
  -2, 3;
  2, -3;
)
$

the corresponding eigenvalues and eigenvectors are:

#align(
  center,
  table(
    columns: 2,
    stroke: none,
    [eigenvalues],
    [eigenvectors],
    $lambda_1 = 0$,
    $u_1 = mat(3; 2)$,
    $lambda_2 = -5$,
    $u_2 = mat(1;-1)$
  )
)

adopt the following transformation:

$
mat(x;y) = mat(
  3, 1; 
  2, -1
) mat(u; v)
$

then the system becomes:

$
mat(dot(u); dot(v)) =
mat(
  0, 0;
  0, -5;
) mat(u; v) + 1/5
mat(
  epsilon(3u+v) + (2u-v)^3 + (3u+v)^3;
  2epsilon(3u+v) + 2(2u-v)^3 - 3(3u+v)^3;
)
$

the center manifold is locally represented by

$
W^c(0) = {(u, v, epsilon) in RR^3 | v = h(u, epsilon), h(0, 0) = 0, D h(0, 0) = 0}
$

Differentiating $v = h(u)$ with respect to time implies that the $(dot(u), dot(v))$
coordinates of any point on $W^c (0)$ must satisfy

$
dot(v) = D h(u) dot(u)
$

assuming that

$
h(u, epsilon) = a_1 u^2 + a_2 epsilon u + a_3 epsilon^2 + dots.c
$

substituting the equation above, it can be obtained that

$
-5h + 1/5[2epsilon(3u+h)+2(2u-h)^3-3(3u+h)^3] = 1/5(2a_1 u + a_2 epsilon + dots.c)[epsilon(3u+h) + (2u-h)^3 + (3u+h)^3]
$

Equating coefficients of like powers to zero gives

$
u^2&: 5 a_1 = 0 &&arrow.double.r a_1 = 0 \
epsilon u&: 5 a_2 - 6/5 = 0 &&arrow.double.r a_2 = 6/25
$

Thus, the center manifold is given by the graph of

$
h(u, epsilon) = 6/25 epsilon u + dots.c
$

the map restricted to the center manifold is given by

$
dot(u) = 1/5 u(3 epsilon + 35 u^2 + dots.c)
$

===  How do the dynamics depend on $epsilon$

#figure(image("figure/4-f-depend.png"))

- if $epsilon >= 0$, there is only one unstable fixed point $(0,0)$
- if $epsilon < 0$, $(0, 0)$ turns into a stable fixed point and two more unstable fixed points appear

== 4.i

=== Draw phase portraits

#table(
  columns: 2,
  stroke: none,
  image("figure/4-i-p01.png"),
  image("figure/4-i-n01.png"),
)

===  Compute the one-parameter family of center manifolds and describe the dynamics on the center manifolds

Jacobian Matrix at fixed point:

$
J = mat(
  delim:"[",
  -2, 1, 1;
  1, -2, 1;
  1, 1, -2;
)
$

the corresponding eigenvalues and eigenvectors are:

#align(
  center,
  table(
    columns: 2,
    stroke: none,
    [eigenvalues],
    [eigenvectors],
    $lambda_1 = 0$,
    $u_1 = mat(1; 1; 1)$,
    $lambda_2 = -3$,
    $u_2 = mat(-1; 0; 1)$,
    $lambda_2 = -3$,
    $u_2 = mat(-1; 1; 0)$
  )
)

adopt the following transformation:

$
mat(x;y;z) = mat(
  1, -1, -1; 
  1, 0, 1;
  1, 1, 0;
) mat(u; v;w)
$

then the system becomes:

$
mat(dot(u); dot(v); dot(w)) =
mat(
  0, 0, 0;
  0, -3, 0;
  0, 0, -3;
) mat(u; v; w) + 1/3
mat(
  3epsilon(u-v-w) - (u+w)^2(u+v) + (u-v-w)(u+v)^2 + (u-v-w)^2(u+w);
  (u+w)^2(u+v) - (u-v-w)(u+v)^2 + 2(u-v-w)^2(u+w);
  (u+w)^2(u+v) + 2(u-v-w)(u+v)^2 - (u-v-w)^2(u+w);
)
$

the center manifold is locally represented by

$
W^c(0) = {(u, v, w, epsilon) in RR^3 | v = h_1(u, epsilon), w = h_2(u, epsilon), h_i(0, 0) = 0, D h_i(0, 0) = 0, i = 1, 2}
$

Differentiating $v = h(u)$ with respect to time implies that the $(dot(u), dot(v))$
coordinates of any point on $W^c (0)$ must satisfy

$
dot(v) = D h(u) dot(u)
$

assuming that

$
h_1(u, epsilon) = a_1 u^2 + a_2 epsilon u + a_3 epsilon^2 + dots.c \
h_2(u, epsilon) = b_1 u^2 + b_2 epsilon u + b_3 epsilon^2 + dots.c
$

substituting the equation above, it can be obtained that

$
&-3h_1 + 1/3[(u+h_2)^2(u+h_1)-(u-h_1-h_2)(u+h_1)^2+2(u-h_1-h_2)^2(u+h_2)] \
= &1/3(2a_1 u + a_2 epsilon + dots.c)[3epsilon(u-h_1-h_2)-(u+h_2)^2(u+h_1)+(u-h_1-h_2)(u+h_1)^2+(u-h_1-h_2)^2(u+h_2)]
$

$
&-3h_2 + 1/3[(u+h_2)^2(u+h_1)+(u-h_1-h_2)(u+h_1)^2+2(u-h_1-h_2)(u+h_2)^2] \
= &1/3(2b_1 u + b_2 epsilon + dots.c)[3epsilon(u-h_1-h_2)-(u+h_2)^2(u+h_1)+(u-h_1-h_2)(u+h_1)^2+(u-h_1-h_2)^2(u+h_2)]
$

Equating coefficients of like powers to zero gives

$
u^2&: cases(-3 a_1 = 0, -3b_1 = 0) &&arrow.double.r cases(a_1 = 0, b_1 = 0) \
epsilon u&: cases(-3 a_2 = 0, -3b_2 = 0) &&arrow.double.r cases(a_2 = 0, b_2 = 0) \
epsilon^2&: cases(-3 a_3 = 0, -3b_3 = 0) &&arrow.double.r cases(a_3 = 0, b_3 = 0) \
u^3&: cases(-3 a_4 + 2/3 = 0, -3b_4 + 2/3 = 0) &&arrow.double.r cases(a_4 = 2/9, b_4 = 2/9) \
$

Thus, the center manifold is given by the graph of

$
h_1(u, epsilon) = 2/9 u^3 + dots.c\
h_2(u, epsilon) = 2/9 u^3 + dots.c
$

the map restricted to the center manifold is given by

$
dot(u) = u(3 epsilon + 1/3 u^2 + dots.c)
$

===  How do the dynamics depend on $epsilon$

#figure(image("figure/4-f-depend.png"))

- if $epsilon >= 0$, there is only one unstable fixed point $(0,0)$
- if $epsilon < 0$, $(0, 0)$ turns into a stable fixed point and two more unstable fixed points appear

