function visualizeAllSignal(data, ax)
  if nargin < 2 || isempty(ax) % default value
      figure; 
      ax = axes;
  else
      axes(ax);
  end

  error = data.error;

  plot(data.time, data.measure, 'b', 'LineWidth', 2); 
  hold on;
  plot(data.time, data.real, 'g', 'LineWidth', 2); 
  plot(data.time, error, 'r', 'LineWidth', 2); 

  legend('IMU Signal', 'Optical Motion Signal', 'Error');
  xlabel('Time (s)');
  ylabel('Signal and Error');
  title(sprintf('IMU vs Optical Motion Signal at Speed: %g km/h', data.gaitSpeed));
  grid on;
end