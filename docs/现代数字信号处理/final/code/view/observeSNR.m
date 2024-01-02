function observeSNR(varargin)  
  snrValues = zeros(1, nargin);
  gaitSpeeds = cell(1, nargin);
  for i = 1:nargin
      snrValues(i) = varargin{i}.SNR;
      gaitSpeeds{i} = sprintf('%.1f km/h', varargin{i}.gaitSpeed);
  end

  T = array2table(snrValues, 'VariableNames', gaitSpeeds, 'RowNames', {'SNR'});   % generate table | 生成表格
  disp(T);
end