class Change < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :post_image_id, :string
    add_column :posts, :user_id, :integer
  end
end
