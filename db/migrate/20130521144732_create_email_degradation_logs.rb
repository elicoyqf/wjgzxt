class CreateEmailDegradationLogs < ActiveRecord::Migration
  def change
    create_table :email_degradation_logs do |t|
      t.string :export_name
      t.datetime :time_begin
      t.datetime :time_end
      t.float :nega_r
      t.float :last_time_r

      t.timestamps
    end
  end
end
