class CreateReportLogs < ActiveRecord::Migration
  def change
    create_table :report_logs do |t|
      t.string :r_type
      t.datetime :r_date
      t.integer :user_id
      t.datetime :view_date
    end
  end
end
