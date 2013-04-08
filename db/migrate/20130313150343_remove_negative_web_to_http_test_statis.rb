class RemoveNegativeWebToHttpTestStatis < ActiveRecord::Migration
  def up
    remove_column :http_test_statis, :negative_web
  end

  def down
    add_column :http_test_statis, :negative_web, :float
  end
end
