function observeAllInFreq(data, ax)
  if nargin < 2 || isempty(ax)
      figure;
      ax = axes;
  else
      axes(ax);
  end

  freq = data.freq;

  plot(ax, freq, data.Ameasure, 'b', 'LineWidth', 2, 'DisplayName', 'IMU Signal');
  hold on;
  plot(ax, freq, data.Areal, 'g', 'LineWidth', 2, 'DisplayName', 'Optical Motion Signal');
  plot(ax, freq, data.Aerror, 'r', 'LineWidth', 2, 'DisplayName', 'Error Signal');

  legend(ax, 'IMU Signal', 'Optical Motion Signal', 'Error Signal');
  title(ax, 'Fourier Transform of Signals');
  xlabel(ax, 'Frequency (Hz)');
  ylabel(ax, '|P1(f)|');
  grid(ax, 'on');

  Settings.getInstance().apply(ax);
end