class ExportName < ActiveRecord::Base
  attr_accessible :name, :status, :user_id
  validates :name, :uniqueness => true

  has_one :user
end
