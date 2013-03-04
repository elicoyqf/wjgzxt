class CreateParamScoreConfigs < ActiveRecord::Migration
  def change
    create_table :param_score_configs do |t|
      t.string :param_name
      t.string :param_type
      t.integer :normal
      t.integer :good
      t.integer :better
      t.integer :bad
      t.integer :worse
      t.integer :weight
      t.integer :item_type
      t.float :lower_limit
      t.float :upper_limit
      t.string :alias

      t.timestamps
    end
  end
end
