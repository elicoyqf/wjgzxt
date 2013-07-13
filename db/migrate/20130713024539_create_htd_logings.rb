class CreateHtdLogings < ActiveRecord::Migration
  def change
    create_table :htd_logings do |t|
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
