clc;
clear;
close all;
%读取数据
data_A1_1 = xlsread('../data-pan/A6_1.xls');   %输出
data_A1_2 = xlsread('../data-pan/A6_2.xls');   %输入
data_A2_1 = xlsread('../data-pan/A4_1.xls');   %输出
data_A2_2 = xlsread('../data-pan/A4_2.xls');   %输入

%辨识用数据
time_A1_1 = data_A1_1(: ,1);
accel_A1_1 = data_A1_1(:, 2) * 9.8; %换算单位
% accel_A1_1 = accel_A1_1 - mean(accel_A1_1); % 移除加速度数据的平均值
accel_A1_2 = data_A1_2(:, 2) * 9.8; %换算单位
% accel_A1_2 = accel_A1_2 - mean(accel_A1_2); % 移除加速度数据的平均值
%同上 验证用数据
time_A2_1 = data_A2_1(: ,1);
accel_A2_1 = data_A2_1(:, 2) * 9.8; 
% accel_A2_1 = accel_A2_1 - mean(accel_A2_1);
accel_A2_2 = data_A2_2(:, 2) * 9.8; 
% accel_A2_2 = accel_A2_2 - mean(accel_A2_2);

% 绘制频谱图，用于滤波器参数选取
% 应用FFT
n = length(accel_A1_1); % 信号长度
Fs = 200; % 采样频率
f = Fs*(0:(n/2))/n; % 频率范围
Y = fft(accel_A1_1); % FFT变换
% 计算双侧谱和单侧谱
P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
% 绘图
figure;
plot(f, P1);
title('单边 FFT');
xlabel('频率 (Hz)');
ylabel('幅值');
xlim([0, 15]);
saveas(gcf, '../figure/freq.png');
accel_A1_1_hp = accel_A1_1;
velocity_A1_1 = cumtrapz(time_A1_1, accel_A1_1_hp);
displacement_A1_1 = cumtrapz(time_A1_1, velocity_A1_1);

figure;
subplot(3,1,1);
plot(time_A1_1, accel_A1_1);
title('加速度');
xlabel('时间 (s)');
ylabel('加速度 (m/s^2)');
% 画出速度-时间图
subplot(3,1,2);
plot(time_A1_1, velocity_A1_1);
title('速度');
xlabel('时间 (s)');
ylabel('速度 (m/s)');
% 画出位移-时间图
subplot(3,1,3);
plot(time_A1_1, displacement_A1_1);
title('位移');
xlabel('时间 (s)');
ylabel('位移 (m)');
saveas(gcf, '../figure/raw.png');

% 设定带通滤波器的频率范围
lowcut = 1.0; % 低频截止，高于漂移的频率
highcut = 10; % 高频截止，低于噪声的频率
% 创建带通滤波器
[b, a] = butter(5, [lowcut highcut]/(Fs/2), 'bandpass');
accel_A1_1_hp = filtfilt(b, a, accel_A1_1); % 应用高通滤波器
accel_A2_1_hp = filtfilt(b, a, accel_A2_1); % 应用高通滤波器
accel_A1_2_hp = filtfilt(b, a, accel_A1_2); % 应用高通滤波器
accel_A2_2_hp = filtfilt(b, a, accel_A2_2); % 应用高通滤波器

% 数值积分计算速度
velocity_A1_1 = cumtrapz(time_A1_1, accel_A1_1_hp);
velocity_A2_1 = cumtrapz(time_A2_1, accel_A2_1_hp);
velocity_A1_2 = cumtrapz(time_A1_1, accel_A1_2_hp);
velocity_A2_2 = cumtrapz(time_A2_1, accel_A2_2_hp);
% 通过优化找到一个速度常数项，以使得积分后的位移尽可能小
options = optimset('Display','off');
velocity_offset1_1 = fminsearch(@(v) sum(abs(cumtrapz(time_A1_1, velocity_A1_1-v))), 0, options);
velocity_offset1_2 = fminsearch(@(v) sum(abs(cumtrapz(time_A1_1, velocity_A1_2-v))), 0, options);
velocity_offset2_1 = fminsearch(@(v) sum(abs(cumtrapz(time_A2_1, velocity_A2_1-v))), 0, options);
velocity_offset2_2 = fminsearch(@(v) sum(abs(cumtrapz(time_A2_1, velocity_A2_2-v))), 0, options);
% 应用找到的速度常数项
velocity_A1_1 = velocity_A1_1 - velocity_offset1_1;
velocity_A1_2 = velocity_A1_2 - velocity_offset1_2;
velocity_A2_1 = velocity_A2_1 - velocity_offset2_1;
velocity_A2_2 = velocity_A2_2 - velocity_offset2_2;
% 继续积分得到位移
displacement_A1_1 = cumtrapz(time_A1_1, velocity_A1_1);
displacement_A1_2 = cumtrapz(time_A1_1, velocity_A1_2);
displacement_A2_1 = cumtrapz(time_A2_1, velocity_A2_1);
displacement_A2_2 = cumtrapz(time_A2_1, velocity_A2_2);
% 移除由于积分漂移导致的趋势
displacement_A1_1 = detrend(displacement_A1_1);
displacement_A1_2 = detrend(displacement_A1_2);
displacement_A2_1 = detrend(displacement_A2_1);
displacement_A2_2 = detrend(displacement_A2_2);

% 参数辨识
A12=(displacement_A1_1-displacement_A1_2).^3;
A14=sign(velocity_A1_1-velocity_A1_2);
A=[displacement_A1_1-displacement_A1_2,A12,velocity_A1_1-velocity_A1_2,A14];
canshu=inv(A'*A)*A'*accel_A1_1_hp % 辨识结果
% 初始猜测值
params0 = [1; 1; 1; 1];  % [alpha1; alpha3; c; mu]

% 目标函数
y = displacement_A1_1-displacement_A1_2;
ydot = velocity_A1_1-velocity_A1_2;
yddot = accel_A1_1_hp;
objective = @(params) systemDynamics(params, y, ydot, yddot);

% 非线性最小二乘优化
params_opt = lsqnonlin(objective, params0)

% 辨识得到的参数
alpha1_opt = params_opt(1)
alpha3_opt = params_opt(2)
c_opt = params_opt(3)
mu_opt = params_opt(4)
% 设置优化问题，objective函数现在返回残差的二范数平方
opts = optimoptions(@fmincon, 'Algorithm', 'interior-point', 'Display', 'iter', 'MaxFunctionEvaluations', 5000);
problem = createOptimProblem('fmincon', 'objective', ...
    @(params) sum(systemDynamics(params, y, ydot, yddot).^2), 'x0', params0, ...
    'options', opts);

% 创建 GlobalSearch 对象
gs = GlobalSearch;

% 运行全局搜索来寻找全局最小值
[params_opt, fval, exitflag, output, solutions] = run(gs, problem);

% 输出结果
alpha1 = params_opt(1)
alpha3 = params_opt(2)
c = params_opt(3)
mu = params_opt(4)

% 显示找到的最小值
% disp(['Global minimum found: fval = ', num2str(fval)]);
% disp(['Exit flag: ', num2str(exitflag)]);
% disp(['Output: ', struct2str(output)]);
% disp(['Solutions: ', struct2str(solutions)]);

neuralnetwork = [displacement_A1_1-displacement_A1_2, velocity_A1_1-velocity_A1_2]; % 神经网络输入
% 预测用
A22=(displacement_A2_1-displacement_A2_2).^3;
A24=sign(velocity_A2_1-velocity_A2_2);
A2=[displacement_A2_1-displacement_A2_2,A22,velocity_A2_1-velocity_A2_2,A24];
neuralnetwork2 = [displacement_A2_1-displacement_A2_2, velocity_A2_1-velocity_A2_2];

% 使用辨识得到的参数canshu来计算预测的加速度
predicted_accel_A2 = A2 * canshu;
% 计算实际加速度和预测加速度之间的RMSE
rmse_error = sqrt(mean((predicted_accel_A2 - accel_A2_1_hp).^2));
% 计算MAE
mae_error = mean(abs(predicted_accel_A2 - accel_A2_1_hp));
% 计算相关系数
correlation_coefficient = corrcoef(predicted_accel_A2, accel_A2_1_hp);
% 显示结果
fprintf('RMSE Error: %f\n', rmse_error);
fprintf('MAE Error: %f\n', mae_error);
fprintf('Correlation Coefficient: \n%s\n', mat2str(correlation_coefficient));
y = displacement_A2_1-displacement_A2_2;
ydot = velocity_A2_1-velocity_A2_2;
yddot = accel_A2_1_hp;
damping_force = c * ydot + mu * sign(ydot);

% 动力学方程的右侧
f_ydot = alpha1 * y + alpha3 * y.^3;
predicted_accel_A2 = -damping_force - f_ydot;
% 计算实际加速度和预测加速度之间的RMSE
rmse_error = sqrt(mean((predicted_accel_A2 - accel_A2_1_hp).^2));
% 计算MAE
mae_error = mean(abs(predicted_accel_A2 - accel_A2_1_hp));
% 计算相关系数
correlation_coefficient = corrcoef(predicted_accel_A2, accel_A2_1_hp);
% 显示结果
fprintf('RMSE Error: %f\n', rmse_error);
fprintf('MAE Error: %f\n', mae_error);
fprintf('Correlation Coefficient: \n%s\n', mat2str(correlation_coefficient));

% 准备测试数据 (假设您的测试数据是 testInputData)
testInputData = neuralnetwork2; % 您的测试输入数据
% 使用神经网络进行预测
Y = myNeuralNetworkFunction(testInputData');
Y = Y';
% 假设您也有测试数据的实际输出 (testTrueOutput)
testTrueOutput = accel_A2_1_hp; % 您的测试真实输出数据
% 计算误差、相关系数
rmse_error = sqrt(mean((Y - testTrueOutput).^2));
mae_error = mean(abs(Y - testTrueOutput));
correlation_coefficient = corrcoef(Y, testTrueOutput);
fprintf('neural RMSE Error: %f\n', rmse_error);
fprintf('neural MAE Error: %f\n', mae_error);
fprintf('neural Correlation Coefficient: \n%s\n', mat2str(correlation_coefficient));

% 画A7、A4数据
% 画出加速度-时间图
figure;
subplot(6,2,1);
plot(time_A1_1, accel_A1_1, 'r');
title('训练数据-输出');
xlabel('时间 (s)');
ylabel('加速度 (m/s^2)');
% 画出速度-时间图
subplot(6,2,3);
plot(time_A1_1, velocity_A1_1, 'g');
title('训练数据-输出');
xlabel('时间 (s)');
ylabel('速度 (m/s)');
% 画出位移-时间图
subplot(6,2,5);
plot(time_A1_1, displacement_A1_1, 'b');
title('训练数据-输出');
xlabel('时间 (s)');
ylabel('位移 (m)');
% 画出加速度-时间图
subplot(6,2,2);
plot(time_A2_1, accel_A2_1, 'r');
title('训练数据-输入');
xlabel('时间 (s)');
ylabel('加速度 (m/s^2)');
% 画出速度-时间图
subplot(6,2,4);
plot(time_A2_1, velocity_A2_1, 'g');
title('训练数据-输入');
xlabel('时间 (s)');
ylabel('速度 (m/s)');
% 画出位移-时间图
subplot(6,2,6);
plot(time_A2_1, displacement_A2_1, 'b');
title('训练数据-输入');
xlabel('时间 (s)');
ylabel('位移 (m)');
% 画出加速度-时间图
subplot(6,2,7);
plot(time_A1_1, accel_A1_2, 'r');
title('测试数据-输出');
xlabel('时间 (s)');
ylabel('加速度 (m/s^2)');
% 画出速度-时间图
subplot(6,2,9);
plot(time_A1_1, velocity_A1_2, 'g');
title('测试数据-输出');
xlabel('时间 (s)');
ylabel('速度 (m/s)');
% 画出位移-时间图
subplot(6,2,11);
plot(time_A1_1, displacement_A1_2, 'b');
title('测试数据-输出');
xlabel('时间 (s)');
ylabel('位移 (m)');
% 画出加速度-时间图
subplot(6,2,8);
plot(time_A2_1, accel_A2_2, 'r');
title('测试数据-输入');
xlabel('时间 (s)');
ylabel('加速度 (m/s^2)');
% 画出速度-时间图
subplot(6,2,10);
plot(time_A2_1, velocity_A2_2, 'g');
title('测试数据-输入');
xlabel('时间 (s)');
ylabel('速度 (m/s)');
% 画出位移-时间图
subplot(6,2,12);
plot(time_A2_1, displacement_A2_2, 'b');
title('测试数据-输入');
xlabel('时间 (s)');
ylabel('位移 (m)');
saveas(gcf, '../figure/train-all.png');
% 画出预测-真实图
figure; 
hold on;
plot(time_A2_1, predicted_accel_A2, 'r', time_A2_1, Y, 'g--', time_A2_1, accel_A2_1_hp, 'b-.'); 
legend('参数辨识', '神经网络', '真值'); 
title('测试结果对比'); 
xlabel('时间'); 
ylabel('加速度'); 
grid on;
hold off; 
saveas(gcf, '../figure/test-compare.png');
neu_test_in = [displacement_A1_1-displacement_A1_2, velocity_A1_1-velocity_A1_2]; %train
neu_test_out = accel_A1_1_hp; % train

neu_for_test_in = [displacement_A2_1-displacement_A2_2, velocity_A2_1-velocity_A2_2];
neu_for_test_out = accel_A2_1_hp; 
%%
function residuals = systemDynamics(params, y, ydot, yddot)
    % 提取参数
    alpha1 = params(1);
    alpha3 = params(2);
    c = params(3);
    mu = params(4);
    
    % 粘性阻尼力和摩擦力
    damping_force = c * ydot + mu * sign(ydot);
    
    % 动力学方程的右侧
    f_ydot = alpha1 * y + alpha3 * y.^3;
    
    % 计算残差
    residuals = yddot + f_ydot + damping_force;
end