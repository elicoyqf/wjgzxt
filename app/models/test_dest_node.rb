class TestDestNode < ActiveRecord::Base
  attr_accessible :dest_node_name, :dest_url, :locale
  validates :dest_node_name, :uniqueness => true
  validates :dest_url, :uniqueness => true
end
