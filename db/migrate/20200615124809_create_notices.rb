class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.string   :announce_title
      t.text   :announce_body
      t.integer :admin_id

      t.timestamps
    end
  end
end
