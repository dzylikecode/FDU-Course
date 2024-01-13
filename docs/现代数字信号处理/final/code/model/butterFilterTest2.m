function out = butterFilterTest2(data)
	Fs  = data.freqSample; 	% sampling frequency 	| 采样频率
	Fc  = 2;                % cutoff frequency 		| 截止频率
	Rp  = 1;                % passband ripple 		| 通带波纹
	Rst = 30;               % stopband attenuation	| 阻带衰减

    n   = 15;               % order of the filter 	| 滤波器阶数
    Wn  = Fc/(Fs/2);        % normalized cutoff frequency | 归一化截止频率
	
	% info
	% 信息
	fprintf('Order of the filter: %d\n', n);
	fprintf('Cutoff frequency: %f\n', Wn);
	
	[b, a] = butter(n, Wn, 'low');

	% filter the data
	% 滤波
	out = filter(b, a, data.measure); 	% filter 会产生相移, 但是用 filtfilt 就不是在线滤波器
end