class CreateVideoTestScores < ActiveRecord::Migration
  def change
    create_table :video_test_scores do |t|
      t.datetime :test_time
      t.string :source_node_name
      t.string :source_ip_address
      t.string :source_group
      t.string :dest_node_name
      t.string :dest_url
      t.string :dest_group
      t.integer :resolution_time
      t.integer :connection_time
      t.integer :time_to_first_byte
      t.integer :time_to_first_frame
      t.integer :total_buffer_time
      t.integer :time_to_first_buffer
      t.integer :avg_butffer_rate
      t.integer :buffering_count
      t.integer :playback_duration
      t.integer :download_time
      t.integer :throuthput_time
      t.integer :playback_rate
      t.integer :resolution_sr
      t.integer :rebuffering_rate
      t.integer :connection_sr
      t.integer :total_sr
      t.string :dest_ip_address
      t.string :dest_nationality
      t.string :dest_province
      t.string :dest_locale
      t.integer :download_size
      t.integer :contents_size
      t.string :return_code
      t.integer :add_ons
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
