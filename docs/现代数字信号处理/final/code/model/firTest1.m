function out = firTest1(data)
	Fs  = data.freqSample; 	% sampling frequency 				| 采样频率
	Fc  = 2;              	% cutoff frequency 					| 截止频率
  N   = 20;               % Number of taps (filter order + 1) | 系数个数
  Wn  = Fc/(Fs/2);        % normalized cutoff frequency 		| 归一化截止频率

	b = fir1(N-1, Wn, hamming(N));

	% filter the data
	% 滤波
	out = filter(b, 1, data.measure);

	[H,f] = freqz(b,1,1024,Fs);
	figure; plot(f,20*log10(abs(H)));
	xlabel('Frequency (Hz)');
	ylabel('Magnitude (dB)');
	title('FIR Filter Frequency Response');
	grid on;
end