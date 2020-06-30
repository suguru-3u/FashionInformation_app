class ChangeContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :solution, :boolean, default: false
  end
end
