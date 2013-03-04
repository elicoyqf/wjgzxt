class CreateVideoTestData < ActiveRecord::Migration
  def change
    create_table :video_test_data do |t|
      t.datetime :test_time
      t.string :source_node_name
      t.string :source_ip_address
      t.string :source_group
      t.string :dest_node_name
      t.string :dest_url
      t.string :dest_group
      t.string :resolution_time
      t.string :connection_time
      t.string :time_to_first_byte
      t.string :time_to_first_frame
      t.string :total_buffer_time
      t.string :time_to_first_buffer
      t.string :avg_butffer_rate
      t.string :buffering_count
      t.string :playback_duration
      t.string :download_time
      t.string :throuthput_time
      t.string :playback_rate
      t.string :resolution_sr
      t.string :rebuffering_rate
      t.string :connection_sr
      t.string :total_sr
      t.string :dest_ip_address
      t.string :dest_nationality
      t.string :dest_province
      t.string :dest_locale
      t.string :download_size
      t.string :contents_size
      t.string :return_code
      t.string :add_ons

      t.timestamps
    end
  end
end
