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
