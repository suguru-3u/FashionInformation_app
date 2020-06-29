class Notes < ActiveRecord::Migration[5.2]
  def change
    change_column :notes, :post_image_id, :string
  end
end
