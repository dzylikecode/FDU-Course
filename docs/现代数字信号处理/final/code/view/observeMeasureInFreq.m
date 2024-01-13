function observeMeasureInFreq(data, ax)
  if nargin < 2 || isempty(ax)
      figure;
      ax = axes;
  else
      axes(ax);
  end

  freq = data.freq;
  A    = data.Ameasure;

  plot(ax, freq, A, 'b', 'LineWidth', 2, 'DisplayName', 'IMU Signal');

  legend(ax, 'IMU Signal');
  title(ax, 'Fourier Transform of IMU Signal');
  xlabel(ax, 'Frequency (Hz)');
  ylabel(ax, '|P1(f)|');
  grid(ax, 'on');

  Settings.getInstance().apply(ax);
end