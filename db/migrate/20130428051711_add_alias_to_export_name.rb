class AddAliasToExportName < ActiveRecord::Migration
  def change
    add_column :export_names, :alias, :string
  end
end
