class ReportLog < ActiveRecord::Base
  attr_accessible :r_date, :r_type, :user_id, :view_date
  validates :r_date, :r_type, :uniqueness => true
  belongs_to :user
end
