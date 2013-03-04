class CreatePingTestScores < ActiveRecord::Migration
  def change
    create_table :ping_test_scores do |t|
      t.datetime :test_time
      t.string :source_node_name
      t.string :source_ip_address
      t.string :source_group
      t.string :dest_node_name
      t.string :dest_url
      t.string :dest_group
      t.string :resolution_time
      t.integer :lost_packets
      t.integer :send_packets
      t.integer :lost_packets_no
      t.integer :delay
      t.integer :max_delay
      t.integer :min_delay
      t.integer :std_delay
      t.integer :jitter
      t.integer :max_jitter
      t.integer :min_jitter
      t.integer :std_jitter
      t.string :dest_ip_address
      t.string :dest_nationality
      t.string :dest_province
      t.string :dest_locale
      t.integer :positive_items
      t.integer :negative_items
      t.integer :equal_items
      t.integer :positive_items_scores
      t.integer :negative_items_scores
      t.integer :equal_items_scores
      t.integer :total_scores

      t.timestamps
    end
  end
end
