class CreatePingTestData < ActiveRecord::Migration
  def change
    create_table :ping_test_data do |t|
      t.datetime :test_time
      t.string :source_node_name
      t.string :source_ip_address
      t.string :source_group
      t.string :dest_node_name
      t.string :dest_url
      t.string :dest_group
      t.string :resolution_time
      t.string :lost_packets
      t.string :send_packets
      t.string :lost_packets_no
      t.string :delay
      t.string :max_delay
      t.string :min_delay
      t.string :std_delay
      t.string :jitter
      t.string :max_jitter
      t.string :min_jitter
      t.string :std_jitter
      t.string :dest_ip_address
      t.string :dest_nationality
      t.string :dest_province
      t.string :dest_locale

      t.timestamps
    end
  end
end
