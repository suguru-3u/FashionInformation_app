class Notice < ActiveRecord::Migration[5.2]
  def change
    remove_column :notices, :admin_id, :integer
  end
end
