class Users < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sex_status, :integer, defalut: 0 
    add_column :users, :age, :integer
  end
end
