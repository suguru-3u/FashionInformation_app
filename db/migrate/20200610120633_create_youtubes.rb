class CreateYoutubes < ActiveRecord::Migration[5.2]
  def change
    create_table :youtubes do |t|
      t.text   :youtube_title
      t.text   :youtube_comment
      t.text   :youtube_url
      t.integer :user_id

      t.timestamps
    end
  end
end
