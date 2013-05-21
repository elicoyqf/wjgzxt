class CreateEmailNotifierLogs < ActiveRecord::Migration
  def change
    create_table :email_notifier_logs do |t|
      t.string :export_name
      t.datetime :time_begin
      t.datetime :time_end
      t.integer :nega_num
      t.integer :total_match_num

      t.timestamps
    end
  end
end
