function observeFilteredData(data, filteredData, ax)
    if nargin < 3 || isempty(ax) % default value
        figure; 
        ax = axes;
    else
        axes(ax);
    end
  
    plot(data.time, data.measure, 'b', 'LineWidth', 2); 
    hold on;
    plot(data.time, data.real, 'g', 'LineWidth', 2); 
    plot(data.time, filteredData, 'r', 'LineWidth', 2); 

    % print MSE
    error = data.real - filteredData;
    mse = mean((error).^2);
    fprintf('Original MSE: %g\n', data.MSE)
    fprintf('MSE: %g\n', mse);
    SNR = snr(data.real, error);
    fprintf('Original SNR: %g\n', data.SNR)
    fprintf('SNR: %g\n', SNR);
    R = corrcoef(data.Areal, data.getSingleAmplitude(filteredData))
    oriR = corrcoef(data.Areal, data.getSingleAmplitude(data.measure))
    fprintf('Original Correlation: %g\n', oriR(1,2));
    fprintf('Correlation: %g\n', R(1,2));


  
    legend('IMU Signal', 'Optical Motion Signal', 'Filtered Data');
    xlabel('Time (s)');
    ylabel('Signal');
    title(sprintf('Filtered Data at speed: %g km/h', data.gaitSpeed));
    grid on;
  end