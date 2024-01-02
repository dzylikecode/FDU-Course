classdef TimeSequence
  properties
    time
    measure
    real
    gaitSpeed
  end
  properties (Dependent)
    error
    SNR           % signal to noise ratio     | 信噪比
    freq          % frequency axis            | 频率轴
    freqSample    % sampling frequency        | 采样频率
    Areal         % real amplitude            | 真值幅值
    Ameasure      % measured amplitude        | 测量幅值
    Aerror        % error amplitude           | 误差幅值
    num           % number of sampling points | 采样点数
    MSE           % mean squared error        | 均方误差
  end
  methods(Static)
    function p = getSingleAmplitude(data)
      N     = length(data);                 % number of sampling points | 采样点数
      Y     = fft(data);                    % fft of real               | 真值的傅里叶变换
      P2    = abs(Y / N);                   % two-sided spectrum        | 双边频谱
      P1    = P2(1 : (N / 2 + 1));          % single-sided spectrum     | 单边频谱
      P1(2 : end - 1) = 2 * P1(2 : end - 1);% single-sided spectrum     | 单边频谱
      p     = P1;
    end
  end
  methods
    function obj = TimeSequence(time, measure, real, gaitSpeed)
      obj.time      = time;
      obj.measure   = measure;
      obj.real      = real;
      obj.gaitSpeed = gaitSpeed;
    end

    function error = get.error(obj)
      error = obj.measure - obj.real;
    end

    function SNR = get.SNR(obj)
      SNR = snr(obj.real, obj.error);           % assume error is noise     | 假定误差为噪声
    end

    function num = get.num(obj)
      num = length(obj.time);                   % number of sampling points | 采样点数
    end

    function freqSample = get.freqSample(obj)
      freqSample = 1 / mean(diff(obj.time));    % sampling frequency        | 采样频率
    end

    function freq = get.freq(obj)
      N     = obj.num;
      time  = obj.time;                      
      Fs    = obj.freqSample;    
      freq  = Fs * (0 : (N / 2)) / N;           % frequency axis            | 频率轴
    end

    function Areal = get.Areal(obj)
      Areal = TimeSequence.getSingleAmplitude(obj.real);
    end

    function Ameasure = get.Ameasure(obj)
      Ameasure = TimeSequence.getSingleAmplitude(obj.measure);
    end

    function Aerror = get.Aerror(obj)
      Aerror = TimeSequence.getSingleAmplitude(obj.error);
    end

    function MSE = get.MSE(obj)
      MSE = mean(obj.error .^ 2);
    end
  end
end