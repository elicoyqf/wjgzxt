class CreateTestDestNodes < ActiveRecord::Migration
  def change
    create_table :test_dest_nodes do |t|
      t.string :dest_node_name
      t.string :dest_url

      t.timestamps
    end
  end
end
