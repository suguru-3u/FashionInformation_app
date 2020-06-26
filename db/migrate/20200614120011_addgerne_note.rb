class AddgerneNote < ActiveRecord::Migration[5.2]
  def change
    remove_column :notes, :genre_id, :integer
  end
end
