% 清除环境变量和图像
clear;
clc;
close all;

% 函数定义
u = linspace(0, 1, 100)';
y1 = 1 ./ (u + 0.1);
y2 = sin(2 * pi * u) + 2 * u;

% 设置 ANFIS 训练参数
numEpochs = 100;

% 使用不同隶属函数宽度和规则数量进行训练和绘图
plot_anfis(u, y1, 4, 'gaussmf', 0.1, 'y = 1 / (u + 0.1) with 4 rules and sigma = 0.1');
plot_anfis(u, y1, 7, 'gaussmf', 0.2, 'y = 1 / (u + 0.1) with 7 rules and sigma = 0.2');
plot_anfis(u, y2, 4, 'gaussmf', 0.1, 'y = sin(2*pi*u) + 2*u with 4 rules and sigma = 0.1');
plot_anfis(u, y2, 7, 'gaussmf', 0.2, 'y = sin(2*pi*u) + 2*u with 7 rules and sigma = 0.2');

% ANFIS 训练和结果绘制函数
function plot_anfis(u, y, numMFs, mfType, sigma, figTitle)
    global numEpochs;
    % 生成训练数据
    data = [u y];

    % 生成初始模糊推理系统
    in_fis = genfis1(data, numMFs, mfType);

    % 设置隶属函数的宽度（标准差）
    for i = 1:numMFs
        in_fis.Inputs.MembershipFunctions(i).Parameters(2) = sigma;
    end

    % 设置 ANFIS 训练选项
    opt = anfisOptions('EpochNumber', numEpochs);

    % 训练 ANFIS
    [trnFis, trnError] = anfis(data, in_fis, opt);

    % 计算 ANFIS 输出
    y_hat = evalfis(trnFis, u);

    % 绘制结果
    figure;
    subplot(2, 1, 1);
    plot(u, y, 'r', 'LineWidth', 2);
    hold on;
    plot(u, y_hat, 'b--', 'LineWidth', 2);
    title([figTitle ' (Function Approximation)']);
    legend('Original', 'ANFIS Approximation');
    xlabel('u');
    ylabel('y');
    grid on;

    subplot(2, 1, 2);
    plotmf(trnFis, 'input', 1);
    title([figTitle ' (Membership Functions)']);
end
