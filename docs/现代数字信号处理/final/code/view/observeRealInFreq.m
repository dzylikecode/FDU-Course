function observeRealInFreq(data, ax)
  if nargin < 2 || isempty(ax)
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
end