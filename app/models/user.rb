class User < ActiveRecord::Base
  attr_accessible :level, :status, :uname, :password, :alias, :email, :contact
  validates :uname, :uniqueness => true
  has_many :export_names
  has_many :report_logs
end
