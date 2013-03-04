class ParamScoreConfig < ActiveRecord::Base
  attr_accessible :bad, :better, :good, :normal, :param_name, :param_type, :worse, :weight, :alias, :lower_limit, :upper_limit, :item_type
end
