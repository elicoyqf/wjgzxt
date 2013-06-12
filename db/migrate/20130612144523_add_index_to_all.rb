class AddIndexToAll < ActiveRecord::Migration
  def change
    add_index :http_test_data, [:test_time, :dest_url]
    add_index :http_test_data, [:test_time, :source_node_name]
    add_index :http_test_data, [:test_time, :dest_node_name, :dest_url], name: 'htd_tdd'
    add_index :http_test_data, [:test_time, :source_node_name, :dest_url], name: 'htd_tsd'

    add_index :http_test_scores, [:dest_url]
    add_index :http_test_scores, [:test_time, :source_node_name]
    add_index :http_test_scores, [:test_time, :source_node_name, :total_scores], name: 'hts_tst'
    add_index :http_test_scores, [:test_time, :source_node_name, :total_scores,:dest_url], name: 'hts_tstd'
    add_index :http_test_scores, [:test_time, :source_node_name, :dest_url, :equal_items_scores, :total_scores], name: 'hts_tsdet'

    add_index :http_test_statis,[:start_time]
    add_index :http_test_statis,[:start_time,:export_name]
    add_index :http_test_statis,[:export_name, :start_time, :end_time, :negative_statis, :total_statis], name: 'hts_esent'
  end

end
