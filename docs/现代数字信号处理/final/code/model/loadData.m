function res = load_data(name)
  path = sprintf('../data/Data_%s.mat', name);
  data = load(path).(name);
  time    = data(:, 1);
  IMU     = data(:, 2);
  motion  = data(:, 3);
  speed   = parseSpeedName(name);
  res = TimeSequence(time, IMU, motion, speed);
end

function speed = parseSpeedName(name)
  if ~ischar(name) && ~isstring(name)
      error('Input must be a string.');
  end

  name = strrep(name, 'S', '');  % S -> ''
  name = strrep(name, 'x', '.'); % x -> .

  speed = str2double(name);

  if isnan(speed)
      error('Unable to parse the input string into a number.');
  end
end