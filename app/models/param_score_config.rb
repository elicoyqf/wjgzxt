class ParamScoreConfig < ActiveRecord::Base
  attr_accessible :bad, :better, :good, :normal, :param_name, :param_type, :worse
end
