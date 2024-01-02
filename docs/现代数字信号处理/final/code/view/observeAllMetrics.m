function observeAllMetrics(varargin)  
  snrValues         = zeros(1, nargin);
  gaitSpeeds        = cell(1, nargin);
  mseValues         = zeros(1, nargin);
  for i = 1:nargin
      snrValues(i)  = varargin{i}.SNR;
      gaitSpeeds{i} = sprintf('%.1f km/h', varargin{i}.gaitSpeed);
      mseValues(i)  = varargin{i}.MSE;
  end

  T = array2table([snrValues; mseValues], ...
        'RowNames', {'SNR', 'MSE'},       ...
        'VariableNames', gaitSpeeds       ...
      );   % generate table | 生成表格
  disp(T);
end