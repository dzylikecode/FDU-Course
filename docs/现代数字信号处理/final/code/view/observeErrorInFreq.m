function observeErrorInFreq(data, ax)
  if nargin < 2 || isempty(ax)
      figure;
      ax = axes;
  else
      axes(ax);
  end

  freq = data.freq;
  A    = data.Aerror;

  plot(ax, freq, A, 'r', 'LineWidth', 2, 'DisplayName', 'Error Signal');

  legend(ax, 'Error Signal');
  title(ax, 'Fourier Transform of Error Signal');
  xlabel(ax, 'Frequency (Hz)');
  ylabel(ax, '|P1(f)|');
  grid(ax, 'on');

  Settings.getInstance().apply(ax);
end