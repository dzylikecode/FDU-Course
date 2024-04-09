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