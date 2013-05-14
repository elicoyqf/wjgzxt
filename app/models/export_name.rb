#encoding : utf-8
class ExportName < ActiveRecord::Base
  attr_accessible :name, :status, :user_id, :alias
  validates :name, :uniqueness => { :scope => :alias }
  #validates :name, :presence => true
  #validates :name, :presence => { :message => '出口名称不能为空' }
  belongs_to :user
end
