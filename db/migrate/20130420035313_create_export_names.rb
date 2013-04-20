class CreateExportNames < ActiveRecord::Migration
  def change
    create_table :export_names do |t|
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
