%% config

clc; clear all; close all;
g = 9.81;
freq = 1000;
delta_t = 1/freq;
train_index = [1, 3, 5];
test_index = [2, 4];
raw_data = {
 load('../data/experimentData1.mat').experimentData;
 load('../data/experimentData2.mat').experimentData;
 load('../data/experimentData3.mat').experimentData;
 load('../data/experimentData4.mat').experimentData;
 load('../data/experimentData5.mat').experimentData;
};
[config_data, config_text, config_all] = xlsread('../data/实验配置记录.xlsx');

config_omega = [
    cellfun(@piText2digital, config_all(2:6, 3))'
    cellfun(@piText2digital, config_all(2:6, 5))'
]';
%% preprocess

data_obj = {};
for i = 1:length(raw_data)
    cur_data = raw_data{i};
    cur_config_omega = config_omega(i, :);
    omega2 = cur_config_omega(1);
    omega3 = cur_config_omega(2);
    d2 = 0.44;
    d3 = 0.37;

    obj = struct;
    obj.hat_theta2  = cur_data(:,1);
    obj.hat_theta3  = cur_data(:,2);
    obj.hat_omega2  = cur_data(:,3);
    obj.hat_omega3  = cur_data(:,4);
    obj.hat_I2      = cur_data(:,5);
    obj.hat_I3      = cur_data(:,6);
    
    obj.theta2 = pi * (obj.hat_theta2 - 460) / 180;
    obj.theta3 = pi * (obj.hat_theta3 - 290) / 180;
    obj.omega2 = pi * (obj.hat_omega2) / 180;
    obj.omega3 = pi * (obj.hat_omega3) / 180;
    obj.alpha2 = - omega2^2 * obj.theta2; %obj.alpha2 = diff(obj.omega2)/delta_t; obj.alpha2(end+1) = obj.alpha2(end);
    obj.alpha3 = - omega3^2 * obj.theta3; %obj.alpha3 = diff(obj.omega3)/delta_t; obj.alpha3(end+1) = obj.alpha3(end);
    obj.tau_m2 = 83.83/1000 * obj.hat_I2;
    obj.tau_m3 = 83.83/1000 * obj.hat_I3;

    for j = 1:length(obj.alpha2)
        alpha2 = obj.alpha2(j); omega2 = obj.omega2(j); theta2 = obj.theta2(j);
        alpha3 = obj.alpha3(j); omega3 = obj.omega3(j); theta3 = obj.theta3(j);

        %%%%%%%%%%%%%%% here is different from solve.mlx:
        %%%%%%%%%%%%%%%     delete the third colum
        A = [
            alpha2, alpha2+alpha3, g*sin(theta2), d2*(alpha3+2*alpha2)*sin(theta3)+d2*(omega3^2+2*omega2^2)*cos(theta3)-g*cos(theta2+theta3);
                 0, alpha2+alpha3,             0, d2*alpha2*sin(theta3)-d2*omega2^2*cos(theta3)+g*cos(theta2+theta3)
        ];
        obj.hat_A(:,:,j) = A;
        obj.A = compressMatrix(obj.hat_A);

        B = [
            sign(omega2), omega2,            0,      0;
                       0,      0, sign(omega3), omega3;
        ];
        
        % B = [
        %     sign(omega2), omega2;
        %     sign(omega3), omega3;
        % ];

        obj.hat_B(:,:,j) = B;
        obj.B = compressMatrix(obj.hat_B);

        C = [A B];
        obj.hat_C(:,:,j) = C;
        obj.C = compressMatrix(obj.hat_C);
    end

    data_obj{i} = obj;
end
%% train

combinations = nchoosek(1:5, 3);
train_obj = {};
for comb_idx = 1:size(combinations, 1)
    t_obj = struct;
    train_index = combinations(comb_idx, :);
    t_obj.train_index = train_index;

    train_C     = [];
    train_tau_m = [];
    for i = train_index
        obj = data_obj{i};
        train_C = [
            train_C;
            obj.C
        ];
    
        tau = reshape([obj.tau_m2 obj.tau_m3]', [], 1);
        train_tau_m = [
            train_tau_m;
            tau;
        ];
    end
    t_obj.train_C = train_C;
    t_obj.train_tau_m = train_tau_m;
                                                            disp('训练组'); disp(train_index);
    condition = cond(train_C);                              fprintf('条件数: %.4e', condition);
    params = pinv(train_C'*train_C)*train_C'*train_tau_m;   disp('最小二乘法参数:'); disp(params);
    t_obj.cond_C = condition;
    t_obj.params = params;

    corr_matrix = corrcoef(train_C); disp('相关系数矩阵:'); disp(corr_matrix);

    % 岭回归
    lambda = 1e-2; % 根据需要调整正则化参数
    params = (train_C' * train_C + lambda * eye(size(train_C, 2))) \ (train_C' * train_tau_m); disp('岭回归调整参数:'); disp(params);
    
    % svd 分解 -> 无用
    % [U, S, V] = svd(train_C, 'econ');
    % threshold = 1e-10;
    % S_inv = diag(1 ./ diag(S));
    % S_inv(diag(S) < threshold) = 0;
    % params = V * S_inv * U' * train_tau_m

    train_obj{comb_idx} = t_obj;
end

%% predict

close all;
k = 7;
use_train_obj = train_obj{7};
use_train_obj.train_index
%% 训练效果
for i = use_train_obj.train_index
    obj = data_obj{i};
    predict_tau_m = obj.C * params;

    predict_tau_m2 = predict_tau_m(1:2:end);
    predict_tau_m3 = predict_tau_m(2:2:end);

    [~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);

    figure;
    t_list = delta_t:delta_t:20;
    plot(t_list, obj.tau_m2, 'g', 'DisplayName', 'Measure');
    hold on;
    plot(t_list, predict_tau_m2, 'r', 'DisplayName', 'Predicted');
    hold off;
    xlabel('t');
    ylabel('\tau_2');
    legend;
    mse2 = immse(obj.tau_m2, predict_tau_m2); fprintf('第%d组, t2: %f', i, mse2);

    saveas(gcf, sprintf('../figure/%s_%d_m2.png', filename, i));

    figure;
    plot(t_list, obj.tau_m3, 'g', 'DisplayName', 'Measure');
    hold on;
    plot(t_list, predict_tau_m3, 'r', 'DisplayName', 'Predicted');
    hold off;
    xlabel('t');
    ylabel('\tau_3');
    legend;
    mse3 = immse(obj.tau_m3, predict_tau_m3); fprintf('第%d组, t3: %f', i, mse3);

    saveas(gcf, sprintf('../figure/%s_%d_m3.png', filename, i));
end

%% 泛化效果
for i = setdiff(1:5, use_train_obj.train_index)
    obj = data_obj{i};
    predict_tau_m = obj.C * params;

    predict_tau_m2 = predict_tau_m(1:2:end);
    predict_tau_m3 = predict_tau_m(2:2:end);

    [~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);

    figure;
    t_list = delta_t:delta_t:20;
    plot(t_list, obj.tau_m2, 'g', 'DisplayName', 'Measure');
    hold on;
    plot(t_list, predict_tau_m2, 'r', 'DisplayName', 'Predicted');
    hold off;
    xlabel('t');
    ylabel('\tau_2');
    legend;
    mse2 = immse(obj.tau_m2, predict_tau_m2); fprintf('第%d组, t2: %f', i, mse2);

    saveas(gcf, sprintf('../figure/%s_%d_m2.png', filename, i));

    figure;
    plot(t_list, obj.tau_m3, 'g', 'DisplayName', 'Measure');
    hold on;
    plot(t_list, predict_tau_m3, 'r', 'DisplayName', 'Predicted');
    hold off;
    xlabel('t');
    ylabel('\tau_3');
    legend;
    mse3 = immse(obj.tau_m3, predict_tau_m3); fprintf('第%d组, t2: %f', i, mse3);

    saveas(gcf, sprintf('../figure/%s_%d_m3.png', filename, i));
end
%%

%%
function B = compressMatrix(A)
%% 把 n m p 矩阵拼接为 (n p) m的二维矩阵
B = reshape(permute(A, [1, 3, 2]), size(A, 1)*size(A, 3), size(A, 2));
end

function d = piText2digital(text)
exp = strrep(text, 'pi', '*pi');
d = eval(exp);
end