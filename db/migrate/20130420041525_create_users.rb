class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uname
      t.integer :status
      t.integer :level
      t.string :password

      t.timestamps
    end
  end
end
