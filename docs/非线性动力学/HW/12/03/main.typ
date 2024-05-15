#image("assets/2024-05-10-11-36-08.png")

given the example of the system

$
cases(
  dot(x) &= epsilon x - y + x^2,
  dot(y) &= x + epsilon y + x^2
)
$

then we know

$
f^1 = x^2, f^2 = x^2, omega = 1
$

so

$
a &= 1/16 (f_(x x x)^1 + f_(x y y)^1 + f_(x x y)^2 + f_(y y y)^2) + 1/(16 omega) (f_(x y)^1 (f_(x x)^1 + f_(y y)^1) - f_(x y)^2 (f_(x x)^2 + f_(y y)^2) - f_(x x)^1 f_(x x)^2 - f_(y y)^1 f_(y y)^2) \
&= 1/16 (2 times 2) \
&= 1/4
$