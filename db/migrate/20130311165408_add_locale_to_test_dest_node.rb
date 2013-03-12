class AddLocaleToTestDestNode < ActiveRecord::Migration
  def change
    add_column :test_dest_nodes, :locale, :string
  end
end
