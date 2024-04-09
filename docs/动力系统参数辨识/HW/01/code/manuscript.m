clc; clear all; close all;

%% config region
config.data.path = '../data-pan';
config.data.fs  = 200;       % 采样频率
config.data.fc  = [1, 50];   % 带通滤波器的低频和高频截止频率
% config.data.rp  = 1;         % 通带波纹，单位为 dB
% config.data.rst = 60;        % 阻带衰减，单位为 dB
config.physic.g = 9.8;
config.butter.n = 5;
%% internal config
getData  = @(path) getDataFull(config, path);
getFreq  = @(data) getFreqFull(config, data);
getFilter= @(data) getFilterFull(config, data);

a = getData('A1_1.xls')
%%
plot(a.times, a.accs, '-');  % 绘制 times vs. accs，并用圆圈标记每个点
xlabel('Time (s)');  % X轴标签
%%
ylabel('Acceleration (m/s^2)');  % Y轴标签
title('Acceleration vs. Time');  % 图表标题
grid on;  % 开启网格
%%
observeAcc(a)
%%
a_freq = getFreq(a)
%%
observeRealInFreq(a_freq, [0, 20])
%%
a_filter = getFilter(a)
observeAcc(a_filter)
%%

%%
function data = getDataFull(config, path)
  rawData = xlsread(fullfile(config.data.path, path));
  data = struct;
  data.times = rawData(: ,1);
  data.accs  = rawData(:, 2) * config.physic.g;
  data.source= path;
end

function observeAcc(data)
figure;
plot(data.times, data.accs, '-'); 
xlabel('Time (s)'); 
ylabel('Acceleration (m/s^2)');  
[filepath, name, ext] = fileparts(data.source);
titleStr = ['Acceleration vs. Time for ', strrep(name, '_', '-')];
title(titleStr);  
grid on;
end

function out = butterFull(config, data)
  Fs  = config.data.fs;   % 采样频率
  Fc  = config.data.fc;   % 带通截止频率，包含低频和高频截止频率
  % Rp  = config.data.rp;   % 通带波纹
  % Rst = config.data.rst;  % 阻带衰减

  % 归一化截止频率
  Wn  = Fc / (Fs / 2);
  % 
  % if any(Wn <= 0 | Wn >= 1)
  %     error('Cutoff frequencies must be between 0 and 0.5 times the sampling rate.');
  % end
  % 
  % % 动态计算滤波器阶数
  % [n, Wn] = buttord(Wn, Wn + [0.05, -0.05], Rp, Rst); % 调整截止频率以满足规格
  % 
  % fprintf('Order of the filter: %d\n', n);
  % fprintf('Cutoff frequencies: %f Hz and %f Hz\n', Wn * (Fs / 2));

  % [b, a] = butter(n, Wn, 'bandpass');

  [b, a] = butter(config.butter.n, Wn, 'bandpass');

  out = filtfilt(b, a, data);  % 使用 filtfilt 避免相移
end

function newData = getFilterFull(config, data)
newData = data;
newData.accs = butterFull(config, data.accs);
end


function p = getSingleAmplitude(data)
  N     = length(data);                 % number of sampling points | 采样点数
  Y     = fft(data);                    % fft of real               | 真值的傅里叶变换
  P2    = abs(Y / N);                   % two-sided spectrum        | 双边频谱
  P1    = P2(1 : (N / 2 + 1));          % single-sided spectrum     | 单边频谱
  P1(2 : end - 1) = 2 * P1(2 : end - 1);% single-sided spectrum     | 单边频谱
  p     = P1;
end

function freq = getFreqAxisFull(config, time)
  N     = length(time);                     
  Fs    = config.data.fs;    
  freq  = Fs * (0 : (N / 2)) / N;       % frequency axis            | 频率轴
end

function freqData = getFreqFull(config, data)
freqData = struct;
freqData.freq = getFreqAxisFull(config, data.times);
freqData.Areal = getSingleAmplitude(data.accs);
end

function observeRealInFreq(data, xRange, ax)
  if nargin < 2 || isempty(xRange)
      xRange = [];
  end

  if nargin < 3 || isempty(ax)
      figure;
      ax = axes;
  else
      axes(ax);
  end

  freq = data.freq;
  A    = data.Areal;

  plot(ax, freq, A, 'g', 'LineWidth', 2, 'DisplayName', 'Optical Motion Signal');

  legend(ax, 'Optical Motion Signal');
  title(ax, 'Fourier Transform of Optical Motion Signal');
  xlabel(ax, 'Frequency (Hz)');
  ylabel(ax, '|P1(f)|');
  grid(ax, 'on');

  if ~isempty(xRange)
    xlim(ax, xRange);
  end
end