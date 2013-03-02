class CreateHttpTestData < ActiveRecord::Migration
  def change
    create_table :http_test_data do |t|
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
      t.string :time_to_index
      t.string :page_download_time
      t.string :page_loading_time
      t.string :total_time
      t.string :throughput_time
      t.string :overall_quality
      t.string :resolution_sr
      t.string :connection_sr
      t.string :index_page_loading_sr
      t.string :page_loading_r
      t.string :loading_sr
      t.string :dest_ip_address
      t.string :dest_nationality
      t.string :dest_province
      t.string :dest_locale
      t.string :download_size
      t.string :contents_size
      t.string :return_code
      t.string :add_ons
      t.string :element_number


      t.timestamps
    end
  end
end
