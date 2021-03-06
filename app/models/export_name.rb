#encoding : utf-8
class ExportName < ActiveRecord::Base
  attr_accessible :name, :status, :user_id, :alias
  #validates :name, :uniqueness => true
  validates :alias, :uniqueness => true
  validates :alias, :uniqueness => { :scope => :name }
  #validates :name, :presence => true
  #validates :name, :presence => { :message => '出口名称不能为空' }
  belongs_to :user
end
