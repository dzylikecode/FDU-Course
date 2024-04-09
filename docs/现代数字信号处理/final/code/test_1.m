% 示例信号生成（正弦波 + 噪声）
Fs = 1000; % 采样频率
t = 0:1/Fs:1-1/Fs; % 时间向量
signal = sin(2*pi*50*t) + sin(2*pi*80*t); % 合成信号
noisy_signal = signal + 0.5*randn(size(t)); % 添加噪声

% 使用小波变换进行去噪
wavelet = 'db1'; % 使用Daubechies小波
[coeffs, L] = wavedec(noisy_signal, 4, wavelet); % 小波分解

% 确定阈值（这里使用Median Absolute Deviation）
sigma = mad(coeffs, 1) / 0.6745;
thresh = sigma * sqrt(2*log(length(noisy_signal)));

% 应用软阈值
coeffs_thresh = wthresh(coeffs, 's', thresh);

% 重构信号
denoised_signal = waverec(coeffs_thresh, L, wavelet);

% 可视化结果
figure;
subplot(3,1,1);
plot(t, noisy_signal);
title('Noisy Signal');
subplot(3,1,2);
plot(t, denoised_signal);
title('Denoised Signal');
subplot(3,1,3);
plot(t, signal);
title('Original Signal');