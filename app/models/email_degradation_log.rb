class EmailDegradationLog < ActiveRecord::Base
  attr_accessible :export_name, :last_time_r, :nega_r, :time_begin, :time_end
end
