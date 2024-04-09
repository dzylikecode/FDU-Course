syms u__0(t) u__1(t) u__2(t) a omega U_0(t) U_1(t) U_2(t) q;
a=1;
omega=1;
u__0(t) = a*cos(omega*t)
u__1(t) = -a^3*cos(omega*t)/32 - (3*a^3*sin(omega*t)*omega*t)/8 + a^3*cos(3*omega*t)/32
u__2(t) = (23*a^5*cos(omega*t))/1024 - (9*cos(omega*t)*a^5*omega^2*t^2)/128 + (3*a^5*omega*t*sin(omega*t))/32 - (9*a^5*omega*t*sin(3*omega*t))/256 + a^5*cos(5*omega*t)/1024 - (3*a^5*cos(3*omega*t))/128
U_1(t)=u__0(t)+q*u__1(t)
U_2(t)=u__0(t)+q*u__1(t)+q^2*u__2(t)


qReal = 0.1;
U_1_q = subs(U_1, q, qReal)
U_2_q = subs(U_2, q, qReal)
figure; % 打开一个新的图形窗口
fplot(U_1_q, [2.5, 5], 'g--', 'LineWidth', 1);hold on;
fplot(U_2_q, [2.5, 5], 'b:', 'LineWidth', 1);


initial_conditions = [a; 0];
tspan = [0 10]; 
% 求解微分方程
[t, y] = ode45(@(t, y) duffing_eqn(t, y, omega, qReal), tspan, initial_conditions);
t_index = find(t >= 2.5 & t <= 5);
plot(t(t_index), y(t_index,1), 'r');
legend('一次近似解', '二次近似解', '数值解'); % 添加图例
xlabel('t'); % x轴标签
ylabel('u(t)'); % y轴标签
title('\epsilon = 0.1'); % 图形标题
hold off;

saveas(gcf, '../figure/01.png');



qReal = 0.2;
U_1_q = subs(U_1, q, qReal)
U_2_q = subs(U_2, q, qReal)
figure; % 打开一个新的图形窗口
fplot(U_1_q, [2.5, 5], 'g--', 'LineWidth', 1);hold on;
fplot(U_2_q, [2.5, 5], 'b:', 'LineWidth', 1);


initial_conditions = [a; 0];
tspan = [0 10]; 
% 求解微分方程
[t, y] = ode45(@(t, y) duffing_eqn(t, y, omega, qReal), tspan, initial_conditions);
t_index = find(t >= 2.5 & t <= 5);
plot(t(t_index), y(t_index,1), 'r');
legend('一次近似解', '二次近似解', '数值解'); % 添加图例
xlabel('t'); % x轴标签
ylabel('u(t)'); % y轴标签
title('\epsilon = 0.2'); % 图形标题
hold off;

saveas(gcf, '../figure/02.png');
%%
function dy = duffing_eqn(t, y, omega, q)
    % 定义方程
    dy = zeros(2,1);
    dy(1) = y(2);
    dy(2) = -omega^2 * y(1) - q * omega^2 * y(1)^3;
end