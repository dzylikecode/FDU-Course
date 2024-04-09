data1 = load_data('S2x0');
data2 = load_data('S2x5');
data3 = load_data('S3x0');

observeOrigin(data1);
%%
figure;
observeOrigin(data1, subplot(3, 1, 1));
observeOrigin(data2, subplot(3, 1, 2));
observeOrigin(data3, subplot(3, 1, 3));
%%
observeFourier(data1);
%%
figure;
observeFourierIMU(data1, subplot(4, 1, 1));
observeFourierMotion(data1, subplot(4, 1, 2));
observeFourierError(data1, subplot(4, 1, 3));
observeFourier(data1, subplot(4, 1, 4));
%%
figure;
observeFourierIMU(data1, subplot(3, 4, 1));  observeFourierMotion(data1, subplot(3, 4, 2));  observeFourierError(data1, subplot(3, 4, 3));  observeFourier(data1, subplot(3, 4, 4));
observeFourierIMU(data2, subplot(3, 4, 5));  observeFourierMotion(data2, subplot(3, 4, 6));  observeFourierError(data2, subplot(3, 4, 7));  observeFourier(data2, subplot(3, 4, 8));
observeFourierIMU(data3, subplot(3, 4, 9));  observeFourierMotion(data3, subplot(3, 4, 10)); observeFourierError(data3, subplot(3, 4, 11)); observeFourier(data3, subplot(3, 4, 12));
%%
calculateSNR(data1)
calculateSNR(data2)
calculateSNR(data3)
%%
calculateSNR_builtin(data1)
calculateSNR_builtin(data2)
calculateSNR_builtin(data3)
%%
function res = load_data(name)
path = sprintf('../data/Data_%s.mat', name);
data = load(path).(name);
res  = struct;
res.time    = data(:, 1);
res.IMU     = data(:, 2);
res.motion  = data(:, 3);
res.speed   = parseSpeedName(name);
end

function speed = parseSpeedName(name)
    if ~ischar(name) && ~isstring(name)
        error('Input must be a string.');
    end

    name = strrep(name, 'S', '');  % S -> ''
    name = strrep(name, 'x', '.'); % x -> .

    speed = str2double(name);

    if isnan(speed)
        error('Unable to parse the input string into a number.');
    end
end

% 绘制 IMU 信号、光学动捕信号和它们之间的误差
function observeOrigin(data, ax)
    if nargin < 2 || isempty(ax) % default value
        figure; 
        ax = axes;
    else
        axes(ax);
    end

    error = data.IMU - data.motion;

    plot(data.time, data.IMU, 'b', 'LineWidth', 2); 
    hold on;
    plot(data.time, data.motion, 'g', 'LineWidth', 2); 
    plot(data.time, error, 'r', 'LineWidth', 2); 

    legend('IMU Signal', 'Optical Motion Signal', 'Error');
    xlabel('Time (s)');
    ylabel('Signal and Error');
    title(sprintf('IMU vs Optical Motion Signal at Speed: %g km/h', data.speed));
    grid on;
end

% 对信号进行傅里叶变换并绘制频谱图
function observeFourier(data, ax)
    if nargin < 2 || isempty(ax)
        figure; 
        ax = axes;
    else
        axes(ax);
    end

    time = data.time;
    imu_signal = data.IMU;
    motion_signal = data.motion;
    error_signal = imu_signal - motion_signal;

    plotFFT(imu_signal, time, ax, 'b', 'IMU Signal');
    hold on;
    plotFFT(motion_signal, time, ax, 'g', 'Optical Motion Signal');
    plotFFT(error_signal, time, ax, 'r', 'Error Signal');

    legend(ax, 'IMU Signal', 'Optical Motion Signal', 'Error Signal');
    title(ax, 'Fourier Transform of Signals');
    xlabel(ax, 'Frequency (Hz)');
    ylabel(ax, '|P1(f)|');
    grid(ax, 'on');
end

function plotFFT(signal, time, ax, color, label)
    N = length(signal);
    fft_signal = fft(signal - mean(signal));
    P2 = abs(fft_signal / N);
    P1 = P2(1:N/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    Fs = 1 / mean(diff(time)); % 采样频率
    f  = Fs*(0:(N/2))/N;       % 频率轴

    plot(ax, f, P1, color, 'LineWidth', 2, 'DisplayName', label);
    xlim(ax, [0 10]); % ! 观察的出来的, 代码不是很自然
end

function observeFourierIMU(data, ax)
    if nargin < 2 || isempty(ax)
        figure;
        ax = axes;
    else
        axes(ax);
    end

    time = data.time;
    imu_signal = data.IMU;

    plotFFT(imu_signal, time, ax, 'b', 'IMU Signal');

    legend(ax, 'IMU Signal');
    title(ax, 'Fourier Transform of IMU Signal');
    xlabel(ax, 'Frequency (Hz)');
    ylabel(ax, '|P1(f)|');
    grid(ax, 'on');
end


function observeFourierMotion(data, ax)
    if nargin < 2 || isempty(ax)
        figure;
        ax = axes;
    else
        axes(ax);
    end

    time = data.time;
    motion_signal = data.motion;

    plotFFT(motion_signal, time, ax, 'g', 'Optical Motion Signal');

    legend(ax, 'Optical Motion Signal');
    title(ax, 'Fourier Transform of Optical Motion Signal');
    xlabel(ax, 'Frequency (Hz)');
    ylabel(ax, '|P1(f)|');
    grid(ax, 'on');
end

function observeFourierError(data, ax)
    if nargin < 2 || isempty(ax)
        figure;
        ax = axes;
    else
        axes(ax);
    end

    time = data.time;
    error_signal = data.IMU - data.motion;

    plotFFT(error_signal, time, ax, 'r', 'Error Signal');

    legend(ax, 'Error Signal');
    title(ax, 'Fourier Transform of Error Signal');
    xlabel(ax, 'Frequency (Hz)');
    ylabel(ax, '|P1(f)|');
    grid(ax, 'on');
end


function snr_db = calculateSNR(data)
    imu_signal    = data.IMU;
    motion_signal = data.motion;

    error_signal = imu_signal - motion_signal;
    signal_power = var(motion_signal);
    noise_power  = var(error_signal);
    
    % Ensure noise power is not zero to avoid division by zero
    if noise_power == 0
        snr_db = Inf;
        return;
    end
    
    snr_linear = signal_power / noise_power;
    snr_db = 10 * log10(snr_linear);
end

function snr_db = calculateSNR_builtin(data)
    imu_signal    = data.IMU;
    motion_signal = data.motion;
    error_signal = imu_signal - motion_signal;

    snr_db = snr(imu_signal,error_signal);
end