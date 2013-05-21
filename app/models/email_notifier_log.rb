class EmailNotifierLog < ActiveRecord::Base
  attr_accessible :export_name, :nega_num, :time_begin, :time_end, :total_match_num
end
