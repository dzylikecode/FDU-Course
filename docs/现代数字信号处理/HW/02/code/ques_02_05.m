clear; clc;
test([1 0 0 -1 0 0 -1 1]);
test([1 2 3 4])
test([1 2])
clc;clear;
% 定义采样率和时间向量
fs = 1000;  % 采样率
T = 1/fs;  % 采样间隔
L = 128;  % 信号长度
t = (0:L-1)*T;  % 时间向量

% 生成正弦信号
f = 50;  % 频率 (Hz)
x = sin(2*pi*f*t);

% 使用DIF2_FFT函数计算FFT
[X_DIF2, Freq_DIF2] = DIF2_FFT(x, fs);

% 使用MATLAB的内置fft函数
X_matlab = fft(x)/fs;
Freq_matlab = fs*(0:(L/2))/L;

% 绘图进行比较
figure;
subplot(2,1,1);
plot(Freq_matlab, abs(X_matlab(1:L/2+1)), 'b', Freq_DIF2(1:L/2+1), abs(X_DIF2(1:L/2+1)), 'r--');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
legend('MATLAB FFT', 'DIF2 FFT');
title('Magnitude Spectrum');

subplot(2,1,2);
plot(Freq_matlab, angle(X_matlab(1:L/2+1)), 'b', Freq_DIF2(1:L/2+1), angle(X_DIF2(1:L/2+1)), 'r--');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
legend('MATLAB FFT', 'DIF2 FFT');
title('Phase Spectrum');
%%
function [X,Freq]=DIF2_FFT(x,fs)
    [xsNew, M] = standard(x);  % Add zeros to the sample to make the length equal to 2^M
    X = FFT_prime(xsNew)/fs;    
    Freq = (0:2^M-1)*fs/2^M;
end

function test(xs)
res = FFT_prime_obeserve(xs);
double(res)
fft(xs)
end
    
function [xsNew, M] = standard(x)
    Nx=length(x);
    M=ceil(log2(Nx));  % Calculate and then ceil the base 2 logarithm. This step makes Nx <= 2^M
    xsNew=zeros(1,2^M);
    xsNew(1:Nx)=x;
end

function X = FFT_prime(xs)
theta = xs.';                                   %; theta = sym(theta)
while getRows(theta) ~= 1
                                                %; disp('---------' + string(getCols(theta)));
    [alpha, beta] = partition(theta);           %; a = observe(alpha), b = observe(beta)
    rotateM = rotateMatrix(getRows(beta));      %; W = observe(rotateM)
    phi_1 = alpha + beta;                       %; phi1 = observe(phi_1)
    phi_2 = rotateM*(alpha - beta);             %; phi2 = observe(phi_2)
    theta = [phi_1 phi_2];                      %; o = observe(theta)
end
X = theta;
end

function X = FFT_prime_obeserve(xs)
theta = xs.';                                   ; theta = sym(theta)
while getRows(theta) ~= 1
                                                ; disp('---------' + string(getCols(theta)));
    [alpha, beta] = partition(theta);           ; a = observe(alpha), b = observe(beta)
    rotateM = rotateMatrix(getRows(beta));      ; W = observe(rotateM)
    phi_1 = alpha + beta;                       ; phi1 = observe(phi_1)
    phi_2 = rotateM*(alpha - beta);             ; phi2 = observe(phi_2)
    theta = [phi_1 phi_2];                      ; o = observe(theta)
end
X = theta;
end
    
function ys = reArrange(xs)
N = length(xs);
n = log2(N);
N_new = 2^n;
ys = zeros(1, N_new);
for i = 1:N
    ys(bitReverse(i-1, n)+1) = xs(i);
end
end

function y = bitReverse(x, n)
bitString = dec2bin(x, n);
reversedBitString = bitString(end:-1:1);
y = bin2dec(reversedBitString);
end

function [firstElms, secondElms] = partition(xs)
firstElms = xs(1:end/2, :);
secondElms = xs(end/2+1:end, :);
end

function cols = getCols(xs)
cols = size(xs, 2);
end

function rows = getRows(xs)
rows = size(xs, 1);
end

function m = rotateMatrix(dims)
n = 2 * dims;
W_n = exp(sym(-1i * 2*pi / n));
dig_W = arrayfun(@(i) W_n^i, 0:dims-1);
m = diag(dig_W);
end

function v = observe(var)
v = var;
latex(var)
end