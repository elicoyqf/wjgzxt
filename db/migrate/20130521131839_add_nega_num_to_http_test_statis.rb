class AddNegaNumToHttpTestStatis < ActiveRecord::Migration
  def change
    add_column :http_test_statis, :negative_num, :integer
    add_column :http_test_statis, :all_match_num, :integer
  end
end
