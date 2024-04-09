#import "@preview/physica:0.9.2": *
#import "@preview/colorful-boxes:1.2.0": *

#set math.equation(numbering: "(1)")
#show link: it => text(fill:blue, underline(it))

#show ref: it => {
  let eq = math.equation
  let el = it.element
  if el != none and el.func() == eq {
    // Override equation references.
    numbering(
      el.numbering,
      ..counter(eq).at(el.location())
    )
  } else {
    // Other references as usual.
    it
  }
}


#let acc(..sink) = {
  let args = sink.pos()
  if args.len() == 1 {
    let var = args.at(0)
    $dot.double(var)$
  } else if args.len() == 2 {
    let var = args.at(0)
    let sub = args.at(1)
    $dot.double(var)_sub$
  } else {
    none
  }
}

= 题 2

#figure(image("assets/2024-04-08-19-45-52.png"))

== 解

采用多尺度的一次近似, 需要用两个时间尺度$T_0$, $T_1$, 有

$
cases(
  D_0^2 x_0 + omega_0^2 x_0 &= F_0 cos omega T_0,
  D_0^2 x_1 + omega_0^2 x_1 &= - 2 D_0 D_1 x_0 - 2 mu D_0 x_0 - alpha x_0^3
)
$

解

$ D_0^2 x_0 + omega_0^2 x_0 &= F_0 cos omega T_0 $

得

$ x_0 = A(T_1) e^(j omega_0 T_0) + Lambda e^(j omega T_0) + "cc" quad Lambda = F_0/(2(omega_0^2-omega^2)) quad A = 1/2 a e^(j phi) $

代入

$
D_0^2 x_1 + omega_0^2 x_1 &= - [2 i omega_0(D_1 A + mu A) + 6 alpha A Lambda^2 + 3 alpha A^2 overline(A)] e^(j omega_0 T_0) \
&quad - alpha (A^3 e^(3 j omega_0 T_0) + Lambda^3 e^(3 j omega T_0) + 3 A^2 Lambda e^(j(2 omega_0 + omega)T_0) \
&quad + 3 overline(A)^2 Lambda e^(j(omega-2omega_0)T_0)+3 A Lambda^2 e^(3j(omega_0+2 omega)T_0)+3 A Lambda^2 e^(j(omega_0-2omega)T_0))\
&quad - Lambda(-2j mu omega + 3 alpha Lambda^2 + 6 alpha A overline(A))e^(j omega T_0)
$

亚谐波共振则有

$ omega = 3 omega_0 + epsilon sigma $

代入

$
3 overline(A)^2 Lambda e^(j (omega - 2 omega_0) T_1) &= 3 overline(A)^2 Lambda e^(j (omega_0 + epsilon sigma) T_1) \
&= 3 alpha overline(A)^2 Lambda e^(j sigma T_1) e^(j omega_0 T_1)
$

$
2 j omega_0(D_1 A + mu A) + 6 alpha A Lambda^2 + 3 alpha A^2 overline(A) + 3 alpha overline(A)^2 Lambda e^(j sigma T_1) = 0
$

可得

$
cases(
  D_1 a &= - [mu + (3 alpha Lambda)/(4 omega_0) a sin (sigma T_1 - 3 phi)]a,
  D_1 phi &= (3 a)/omega_0 [Lambda^2 + 1/8 a^2 + Lambda/4 a cos(sigma T_1 - 3 phi)]
)
$

令$gamma = sigma T_1 - 3 phi$, 则有

$
cases(
  D_1 a &= -(mu + (3 alpha Lambda)/(4 omega_0) a sin gamma)a,
  D_1 gamma &= sigma - (9 a)/omega_0 [Lambda^2 + 1/8 a^2 + Lambda/4 a cos gamma]
)
$

令$D_1 a = 0, D_1 gamma  = 0$, 则有

$
cases(
  mu &= - (3 alpha Lambda)/(4 omega_0) a_s sin gamma_s,
  sigma - (9 alpha)/(omega_0) (Lambda^2 + a_s^2 / 8) &= (9 alpha Lambda)/(4 omega_0) a_s cos gamma_s
)
$

消去$gamma_s$, 则有

$
9 mu^2 + (sigma - (9 alpha Lambda^2)/omega_0 - (9 alpha)/(8 omega_0) a_s^2)^2 = (81 alpha^2 Lambda^2) /(16 omega_0^2) a_s^2
$

得

$
a_s^4 + 2 p a_s^2 + q = 0
$

其中,

$
cases(
  p &= (8 omega_0 sigma)/(9 alpha) - 6 Lambda^2,
  q &= ((8 omega_0)/(9 alpha))^2[9 mu^2 + (sigma - (9 alpha Lambda^2)/omega_0)^2]
)
$

解得

$
a_s^2 = p plus.minus sqrt(p^2 - q)
$

若有实数解, 则要求

$
cases(
  p &> 0,
  p^2 &> q,
)
quad arrow.double.l.r quad
cases(
  Lambda^2 &< (4 omega_0 sigma) /(27 alpha),
  (alpha Lambda^2)/omega_0(sigma - (63 alpha Lambda^2)/(8 omega_0)) - 2 mu^2 &>= 0
)
$

引入参数

$
cases(
  beta &= sigma / mu,
  Gamma &= (63 alpha Lambda^2) /(4 omega_0 mu)
)
$

不等式变为

$
cases(
  Gamma &< 7/3 beta,
  Gamma^2 - 2 beta Tau + 63 &<= 0,
)
$

则给定$sigma$振幅$a_s$有实数解的条件为

$
beta - (beta^2 - 63)^(1/2) <= Gamma <= beta + (beta^2 - 63)^(1/2) < 7/3 beta
$

== 作图

#table(
  columns: 3,
  stroke: none,
  image("figure/figure-1.png"),
  image("figure/figure-2.png"),
  image("figure/phase_portrait.png")
)

== 代码

```matlab
% 定义beta的范围
beta = linspace(0, 20, 400);  % 包括负值和正值的区间

% 计算对应的Gamma值
Gamma_lower = beta - sqrt(beta.^2 - 63);
Gamma_upper = beta + sqrt(beta.^2 - 63);

% 为了防止复数结果，我们只在beta^2 - 63 >= 0的情况下计算Gamma
valid_indices = beta.^2 >= 63;
beta_valid = beta(valid_indices);
Gamma_lower_valid = Gamma_lower(valid_indices);
Gamma_upper_valid = Gamma_upper(valid_indices);

% 绘制Gamma的下界和上界
figure;
hold on;
fill([beta_valid, fliplr(beta_valid)], [Gamma_lower_valid, fliplr(Gamma_upper_valid)], 'b', 'FaceAlpha', 0.5);
xlabel('$\beta$', 'Interpreter', 'latex');
ylabel('$\Gamma$', 'Interpreter', 'latex');
title('亚谐波共振存在的区域');
hold off;
saveas(gcf, '../figure/figure-1.png');
%%
% 载入符号计算工具箱
syms mu sigma alpha Lambda omega_0 a_s omega

% 定义方程
eq = 9*mu^2 + (sigma - (9*alpha*Lambda^2)/omega_0 - (9*alpha)/(8*omega_0)*a_s^2)^2 == (81*alpha^2*Lambda^2)/(16*omega_0^2)*a_s^2

% 给定的参数值
omega_0_val = 1;
epsilon_val = 0.5;
F_0_val = 12;
alpha_val = 1;
sigma_val = (omega - 3) / epsilon_val;
Lambda_val = F_0_val / (2 * (omega_0_val^2 - omega^2));

eq_substituted = subs(eq, {omega_0, alpha, sigma, Lambda}, ...
                      {omega_0_val, alpha_val, sigma_val, Lambda_val})

% 解方程，求mu和sigma
solution = solve(eq_substituted, a_s)

sol = [solution(1); solution(2)]

sol_mu_0 = subs(sol, mu, 0.0);
sol_mu_1 = subs(sol, mu, 0.1);
sol_mu_2 = subs(sol, mu, 0.2);
sol_mu_3 = subs(sol, mu, 0.3);

omega_range = [3 5];

fplot(sol_mu_0, omega_range)
hold on;
fplot(sol_mu_1, omega_range)
fplot(sol_mu_2, omega_range)
fplot(sol_mu_3, omega_range)

% 设置图例
legend('$\mu = 0$', '$\mu = 0.1$', '$\mu = 0.2$', '$\mu = 0.3$', 'Interpreter', 'latex', 'Location', 'northwest');

% 设置坐标轴标签
xlabel('$\omega$', 'Interpreter', 'latex');
ylabel('$a_s$', 'Interpreter', 'latex');
hold off;
saveas(gcf, '../figure/figure-2.png');

%%
% 参数定义
mu = 0.1;
alpha = 1;
omega_0 = 1;
epsilon = 0.5;
omega = 3.5;
F_0 = 12;
sigma = omega / epsilon; % 由给出的omega和epsilon计算sigma
Lambda = F_0 / (2 * (omega_0^2 - omega^2)); % 计算Lambda

% 定义微分方程系统
odefun = @(t, y) [- (mu + 3 * alpha * Lambda / (4 * omega_0) * y(1) * sin(y(2))) * y(1);
                   sigma - (9 * y(1) / omega_0) * (Lambda^2 + (1/8) * y(1)^2 + (Lambda/4) * y(1) * cos(y(2)))];

% 设置图形窗口
figure;

% 求解微分方程并绘图，对于两个不同的初始条件
for initial_conditions = [1.5, 0; 2, 0.5;]'
    [t, y] = ode45(odefun, [0 10], initial_conditions);
    % 将 y(:,2) 的值调整到 [-pi, pi] 范围内
    y(:,2) = mod(y(:,2) + pi, 2*pi) - pi;
    plot(y(:,1), y(:,2));
    hold on;
end

% 设置坐标轴标签和标题
xlabel('$a$', 'Interpreter', 'latex');
ylabel('$\varphi$', 'Interpreter', 'latex');
title('相轨图');

% 显示网格并保持坐标轴比例相同
grid on;
axis equal;

% 关闭持续绘图模式
hold off;

% 保存图像
saveas(gcf, '../figure/phase_portrait.png');
```