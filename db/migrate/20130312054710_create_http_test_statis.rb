class CreateHttpTestStatis < ActiveRecord::Migration
  def change
    create_table :http_test_statis do |t|
      t.string  :export_name
      t.datetime :start_time
      t.datetime :end_time
      t.float :negative_statis
      t.float :total_statis
      t.integer :negative_web

      t.timestamps
    end
  end
end
