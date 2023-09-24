# HW-1

## problem 01

$$
\begin{aligned}
x_h &= e^{-\xi \omega_n t} ( \alpha e^{i \omega_d t} + \beta e^{-i \omega_d t} ) \\
&= e^{-\xi \omega_n t} [ ( \alpha + \beta ) \cos \omega_d t + i ( \alpha - \beta ) \sin \omega_d t ]
\end{aligned}
$$

$$
\begin{cases}
\alpha + \beta = \overline {\alpha + \beta} \\
i(\alpha - \beta) = \overline {i(\alpha - \beta)}
\end{cases}
$$

$$
\begin{cases}
r^2 +p\,r+q=0 \quad &(1) \\
\ddot u + (2r + p)\dot u + (r^2 +p\,r+q) u = 0 \quad &(2)
\end{cases}
$$

![](HW-01-01.drawio.svg)

- <a class="Pages" target="_blank" href="HW-01-01.drawio.svg">svg version</a>

## problem 02

![](HW-01-02.drawio.svg)

## problem 03

![](HW-01-03.drawio.svg)

## problem 04

![](HW-01-04.drawio.svg)

## problem 05

![](HW-01-05.drawio.svg)

- [Solve Differential Equation - MATLAB & Simulink](https://www.mathworks.com/help/symbolic/solve-a-single-differential-equation.html): key function is `dsolve`
- [Solve a System of Differential Equations - MATLAB & Simulink](https://www.mathworks.com/help/symbolic/solve-a-system-of-differential-equations.html): use [eq1; eq2] to represent a system of equations
- [Equations and systems solver - MATLAB solve](https://www.mathworks.com/help/symbolic/sym.solve.html): key function is `solve`, but it can't solve differential equation

> 如何替换 res 中的通解系数

Using Mathematica/MATLAB, please derive the steady-state response (i.e., the particular solution) of the following SDOF system $$m\ddot{x}+c\dot{x}+kx=F_0\sin(\omega_f t)$$. Based on the response, please plot the amplitude-frequency response curve (use the ratio of frequency) of the system.

```matlab
clear; clc;
syms t x(t) c k F_0 omega_f m
f = @(v) m * diff(x, 2) + c * diff(v, 1) + k * v;
eq = f(x) == F_0 * sin(omega_f*t)
res = dsolve(eq)
```

## problem 06

![](HW-01-06.drawio.svg)

## problem 07

![](HW-01-07.drawio.svg)

```matlab
clear; clc;
T = 4;
f = @(t) mod(t-T/2, T) - T/2;
fplot(f, [-2*T, 2*T]);
xlim([-2*T, 2*T]);
ylim([-T, T]);

m = 1;
c = 0.2;
k = 10;
time_span = [0, 50];
x_init = [
    0;
    0];
[t,x] = ode45(@(t, x) vdp1(t, x, f, m, c, k), time_span, x_init);
plot(t,x(:,1),'-o',t,x(:,2),'-o')
title('Solution of $m \ddot x + c \dot x + k x = f(t)$ with ODE45', 'Interpreter','Latex');
xlabel('$t$', 'Interpreter','Latex');
ylabel('reponse', 'Interpreter','Latex');
legend('$x$','$\dot x$', 'Interpreter','Latex');

function dydt = vdp1(t, x, f, m, c, k)
  dydt = [
      x(2);
      (f(t) - c*x(2) - k*x(1))/m];
end
```

- [Solve nonstiff differential equations — medium order method - MATLAB ode45](https://www.mathworks.com/help/matlab/ref/ode45.html#bu00_4l_sep_shared-y0)

## problem 08

![](HW-01-08.drawio.svg)

## problem 09

![](HW-01-09.drawio.svg)

## problem 10

![](HW-01-10.drawio.svg)

## issue

我定义了一个符号函数, 然后想计算矩阵, 如下, 如何修复代码

```matlab
syms t

f = sin(t)

test_t = [1, 2, 3];
f(test_T)

```

---

GitHub Copilot: 在这段代码中，变量 `test_t` 的大小为 `1x3`，而符号函数 `f` 的输入参数应该是一个标量。因此，我们需要对 `test_t` 中的每个元素分别计算符号函数的值。可以使用 `arrayfun` 函数来实现这个功能。以下是修复后的代码：

```matlab
syms t

f = sin(t);

test_t = [1, 2, 3];
f_test_t = arrayfun(@(x) double(subs(f, t, x)), test_t);
```

在这个修复后的代码中，我们使用 `arrayfun` 函数对 `test_t` 中的每个元素应用一个匿名函数，该匿名函数使用 `subs` 函数将符号函数 `f` 中的 `t` 替换为当前元素，并使用 `double` 函数将结果转换为双精度数。最后，我们将结果存储在 `f_test_t` 中。运行这段代码可以得到 `f_test_t` 数组，它的值为 `[0.8415, 0.9093, 0.1411]`。
