class CreateWebHitRateStatis < ActiveRecord::Migration
  def change
    create_table :web_hit_rate_statis do |t|
      t.datetime :time_begin
      t.string :url
      t.float :dx_hit_rate
      t.float :lt_hit_rate

      t.timestamps
    end
  end
end
