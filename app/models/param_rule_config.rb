class ParamRuleConfig < ActiveRecord::Base
  attr_accessible :item_type, :lower_limit, :param_name, :param_type, :upper_limit
end
