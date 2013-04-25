class ReportLog < ActiveRecord::Base
  attr_accessible :r_date, :r_type, :user_id, :view_date
  validates :r_type, :uniqueness => { :scope => [:r_date,:user_id] }
  belongs_to :user
end
