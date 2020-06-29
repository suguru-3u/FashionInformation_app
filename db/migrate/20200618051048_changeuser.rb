class Changeuser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :sex_status, :integer
    remove_column :users, :age, :integer
    add_column :posts, :solution, :boolean, default: false
  end
end
