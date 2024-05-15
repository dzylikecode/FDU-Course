#image("assets/2024-05-09-23-29-37.png")

#image("assets/2024-05-09-23-29-54.png")

#image("assets/2024-05-09-23-30-17.png")

== 1.a

It's easy to integrate the equation

$
dot(r) = -r(r-mu)^2

arrow.double.l.r - 1/(r(r-mu)^2) dif r = dif t
$

Obviously, fixed point $r = 0$ is stable by the solution of the equation.

And $r = mu$ is a periodic orbit.

So, $(2)$ is the phase portrait of $(a)$.

the equation can be written as

$
mat(dot(r); dot(theta)) =
mat(
  - mu^2, 0;
  0, 0;
) mat(r; theta)
+
mat(
  -r^3 + 2 mu r^2;
  1
)
$

the eigenvalues of the Jacobian matrix at fixed point $(0, 0)$ are

$
lambda_1 = - mu^2, lambda_2 = 0
$

- $f(0, mu) = 0$ and $"Re" (lambda(0)) = 0$ are satisfied
- $(dif "Re" (lambda))/(dif mu) |_(mu = 0) = 0$ voilates the hypothese that $(dif "Re" (lambda))/(dif mu) |_(mu = 0) eq.not 0$

== 1.c

It's easy to integrate the equation

$
dot(r) = r(r+mu)(r-mu)

arrow.double.l.r 1/(r(r+mu)(r-mu)) dif r = dif t
$

Obviously, fixed point $r = 0$ is unstable by the solution of the equation.

And $r = plus.minus mu$ is a periodic orbit.

So, $(4)$ is the phase portrait of $(c)$.

the equation can be written as

$
mat(dot(r); dot(theta)) =
mat(
  mu^2, 0;
  0, 0;
) mat(r; theta)
+
mat(
  r^3;
  1
)
$

the eigenvalues of the Jacobian matrix at fixed point $(0, 0)$ are

$
lambda_1 = mu^2, lambda_2 = 0
$

- $f(0, mu) = 0$ and $"Re" (lambda(0)) = 0$ are satisfied
- $(dif "Re" (lambda))/(dif mu) |_(mu = 0) = 0$ voilates the hypothese that $(dif "Re" (lambda))/(dif mu) |_(mu = 0) eq.not 0$