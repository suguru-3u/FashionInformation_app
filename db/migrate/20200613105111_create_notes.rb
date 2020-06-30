class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string   :note_title
      t.text   :note_body
      t.integer :genre_id
      t.integer :post_image_id
      
      t.timestamps
    end
  end
end
