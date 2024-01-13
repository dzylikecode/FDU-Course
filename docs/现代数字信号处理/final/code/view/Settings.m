classdef Settings < handle %singleton | 单例
  properties
    xRange = [];
  end
  
  methods (Access = private)
    function obj = Settings
    end
  end
  
  methods (Static)
    function singleObj = getInstance
      persistent instance;
      if isempty(instance) || ~isa(instance, 'Settings')
          instance = Settings;
      end
      singleObj = instance;
    end
  end

  methods
    function apply(obj, ax)
      if ~isempty(obj.xRange)
        xlim(ax, obj.xRange);
      end
    end

    function obj = setXRange(obj, value)
      obj.xRange = value;
    end
  end
end