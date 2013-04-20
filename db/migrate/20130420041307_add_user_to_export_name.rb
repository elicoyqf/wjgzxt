class AddUserToExportName < ActiveRecord::Migration
  def change
    add_column :export_names, :user_id, :integer
  end
end
