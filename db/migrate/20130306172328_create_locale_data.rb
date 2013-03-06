class CreateLocaleData < ActiveRecord::Migration
  def change
    create_table :locale_data do |t|
      t.string :locale_name
      t.integer :locale_number

      t.timestamps
    end
  end
end
