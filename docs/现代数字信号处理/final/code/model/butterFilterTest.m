function out = butterFilterTest(data)
	Fs  = data.freqSample; 	% sampling frequency 	| 采样频率
	Fp  = 2;                % passband frequency 	| 通带频率
	Fst = 3;              	% stopband frequency 	| 阻带频率
	Rp  = 1;                % passband ripple 		| 通带波纹
	Rst = 30;               % stopband attenuation	| 阻带衰减
	
	% calculate normalized frequency(MATLAB frequency is relative to Nyquist frequency)
	% 计算归一化频率(MATLAB 中的频率是相对于 Nyquist 频率的)
	Wp 	= Fp/(Fs/2);					% normalized passband frequency 	| 归一化通带频率
	Wst = Fst/(Fs/2);					% normalized stopband frequency 	| 归一化阻带频率

	[n, Wn] = buttord(Wp, Wst, Rp, Rst);% calculate the order and cutoff frequency of the filter | 计算滤波器的阶数和截止频率

	% info
	% 信息
	fprintf('Normalized passband frequency: %f\n', Wp);
	fprintf('Normalized stopband frequency: %f\n', Wst);
	fprintf('Order of the filter: %d\n', n);
	fprintf('Cutoff frequency: %f\n', Wn);
	
	[b, a] = butter(n, Wn, 'low');

	% filter the data
	% 滤波
	out = filter(b, a, data.measure); 	% 会产生相移, 但是用 filtfilt 就不是在线滤波器
end