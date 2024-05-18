#import "@preview/colorful-boxes:1.2.0": *


#let vel(..sink) = {
  let args = sink.pos()
  if args.len() == 1 {
    let var = args.at(0)
    $dot(var)$
  } else if args.len() == 2 {
    let var = args.at(0)
    let sub = args.at(1)
    $dot(var)_sub$
  } else {
    none
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

== (1)

选择1, 2, 3作为训练数据, 4, 5作为测试数据

== (2)

计算导数有两种方式

+ 根据差分的方法

  已知采样频率, 则可以计算出采样时间间隔, 从而计算近似的加速度

  $
  acc(theta) = (vel(theta, k+1) - vel(theta, k)) / (Delta t)
  $

+ 根据给出的了激励的形式为正弦形, 则

  $ theta = A cos omega t $

  可得

  $
  acc(theta) = - A omega^2 cos omega t = - omega^2 theta
  $

采用第二种方式比较精确一些

== (3)

假设摩擦力矩模型为:

$
tau_f = mu_c "sgn"(vel(theta)) + mu_v vel(theta)
$

- $mu_c$是库伦摩擦系数
- $mu_v$是粘性摩擦系数

由于驱动力矩与摩擦力矩应该是异号的, 为确保参数$mu_c, mu_v > 0$, 则

$
&A mu = mat(
  - mu_(c 2) "sgn"(vel(theta, 2)) - mu_(v 2) vel(theta, 2);
  - mu_(c 3) "sgn"(vel(theta, 3)) - mu_(v 3) vel(theta, 3);
) + tau_m \
arrow.double.l.r
&A mu + mat(
  mu_(c 2) "sgn"(vel(theta, 2)) + mu_(v 2) vel(theta, 2);
  mu_(c 3) "sgn"(vel(theta, 3)) + mu_(v 3) vel(theta, 3);
) = tau_m
$

则可设

$
B = mat(
  "sgn"(vel(theta, 2)), vel(theta, 2), 0, 0;
  0, 0, "sgn"(vel(theta, 3)), vel(theta, 3);
) quad
lambda = mat(
  mu_(c 2);
  mu_(v 2);
  mu_(c 3);
  mu_(v 3);
)
$

可得

$
mat(A, B) mat(mu; lambda) = tau_m
$

== (4)

采用最小二乘法进行辨识则有

$
mat(mu; lambda) = (C^T C)^(-1) C^T tau_m quad C = mat(A, B)
$

#place(dx: 350pt, dy:-55pt, stickybox(width: 4.5cm, [
  #set text(size: 8pt)
  多组数据可以按照列拼接为一个大的矩阵

  $C_i mat(mu; lambda) = tau_(m i), quad C_j mat(mu; lambda) = tau_(m j)$

  则有

  $mat(C_i; C_j) mat(mu; lambda) = mat(tau_(m i); tau_(m j))$
]))

选取$2, 3, 4$组作为训练数据,

计算得到矩阵$C$的条件数

$
"cond"(C) = 4.9724 times 10^15
$

发现非常大

分析矩阵的相关矩阵为

$
"corrcoef"(C) = mat(
1.0000, 0.5991, -0.7798, -0.8166, 0.4014, -0.0116, -0.0216, -0.0001, 0.0000;
0.5991, 1.0000, -0.5803, -0.5935, 0.0056, -0.0070, -0.0126, -0.0048, -0.0088;
-0.7798, -0.5803, 1.0000, 0.9981, -0.1235, 0.0090, 0.0156, 0.0000, -0.0000;
-0.8166, -0.5935, 0.9981, 1.0000, -0.1530, 0.0094, 0.0165, 0.0000, -0.0000;
0.4014, 0.0056, -0.1235, -0.1530, 1.0000, 0.0005, 0.0007, -0.0006, -0.0007;
-0.0116, -0.0070, 0.0090, 0.0094, 0.0005, 1.0000, 0.8298, -0.0000, 0.0000;
-0.0216, -0.0126, 0.0156, 0.0165, 0.0007, 0.8298, 1.0000, -0.0000, 0.0000;
-0.0001, -0.0048, 0.0000, 0.0000, -0.0006, -0.0000, -0.0000, 1.0000, 0.8484;
0.0000, -0.0088, -0.0000, -0.0000, -0.0007, 0.0000, 0.0000, 0.8484, 1.0000;
)
$

可以看到$3, 4$之间的相关程度为$0.9981$, 非常的高

说明这两列之间是线性相关的

$
mat(
  d_2^2 acc(theta, 2)+g d_2 sin theta_2, g sin theta_2;
  0, 0;
)
$

经分析, 有

$
d_2^2 acc(theta, 2) &= d_2^2 (-omega_2^2 theta_2) \
&= -omega_2^2 d_2^2 theta_2 \
&approx -omega_2^2 d_2^2 sin theta_2 \
$

所以

$
d_2^2 acc(theta, 2) + g d_2 sin theta_2 &approx (- (omega_2^2 d_2^2)/g + d_2) g sin theta_2
$

因此, 删除线性相关的列, 选择删除了第三列, 修改模型为

$
&A arrow A = mat(
  acc(theta, 2), acc(theta, 2)+acc(theta, 3), g sin theta_2, d_2 (acc(theta, 3)+2 acc(theta, 2)) sin theta_3 + d_2 (vel(theta, 3)^2 + 2 vel(theta, 2)^2) cos theta_3 - g cos(theta_2+theta_3);
  0, acc(theta, 2)+acc(theta, 3), 0, d_2 acc(theta, 2) sin theta_3 - d_2 vel(theta, 2)^2 cos theta_3 + g cos(theta_2+theta_3);
)\

&mu arrow mu = mat(
  J_2 + m_2 l_2^2;
  J_3 + m_3 l_3^2;
  m_3 (- (omega_2^2 d_2^2)/ g + d_2) + m_2 l_2;
  m_3 l_3
)
$

此时矩阵的条件数为

$
"cond"(C) = 164.75
$

矩阵较为良好

训练后辨识的参数为

$
mat(
    2.2249,
    0.3279,
   -2.4288,
   -0.4755,
    8.6019,
   21.2938,
    8.5800,
   29.6470,
)
$

#place(dx: 400pt, dy:-55pt, stickybox(width: 4cm, [
  #set text(size: 8pt)
  可以看到, 第三个和第四个参数为负的, 与实际意义不相符

  然而预测效果基本不错
]))

训练效果如下

#align(
  center,
  table(
  columns: 3,
  stroke: none,
  [],
  $tau_2$,
  $tau_3$,
  [组2],
  image("figure/solve_real_2_m2.png"),
  image("figure/solve_real_2_m3.png"),
  [组3],
  image("figure/solve_real_3_m2.png"),
  image("figure/solve_real_3_m3.png"),
  [组4],
  image("figure/solve_real_4_m2.png"),
  image("figure/solve_real_4_m3.png"),
)
)

辨识的均方误差

#align(
  center,
  table(
  columns: 3,
  stroke: none,
  [],
  $tau_2$,
  $tau_3$,
  [组2],
  [2.262958],
  [1.569025],
  [组3],
  [3.855512],
  [4.079979],
  [组4],
  [2.327019],
  [2.016972],
)
)

== (5)

预测的效果如图

#align(
  center,
  table(
  columns: 3,
  stroke: none,
  [],
  $tau_2$,
  $tau_3$,
  [组1],
  image("figure/solve_real_1_m2.png"),
  image("figure/solve_real_1_m3.png"),
  [组5],
  image("figure/solve_real_5_m2.png"),
  image("figure/solve_real_5_m3.png"),
)
)

均方误差

#align(
  center,
  table(
  columns: 3,
  stroke: none,
  [],
  $tau_2$,
  $tau_3$,
  [组1],
  [2.464666],
  [1.494122],
  [组5],
  [5.758076],
  [3.172052],
)
)

思考:

参数线性化的好处

- 简化复杂模型: 非线性模型通常很复杂且难以处理, 而通过线性化可以将复杂的非线性问题转换为相对简单的线性问题
- 线性辨识方法成熟: 线性化后的模型可以直接应用线性辨识方法(如最小二乘法), 这些方法成熟且高效

这里根据尽可能的合并同类项的方式, 得到了5个含有未知参数的的项, 进而定义了5个参数, 目的是为了尽量简单. 但是由于数值上的问题, 在近似的角度上, 第三个和第四个参数为实际上是线性相关的, 所以采用定义 4 个广义结构参数更好

== 代码

```matlab
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
```
