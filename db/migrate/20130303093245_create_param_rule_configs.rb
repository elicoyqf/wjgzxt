class CreateParamRuleConfigs < ActiveRecord::Migration
  def change
    create_table :param_rule_configs do |t|
      t.string :param_name
      t.string :param_type
      t.integer :item_type
      t.float :lower_limit
      t.float :upper_limit

      t.timestamps
    end
  end
end
