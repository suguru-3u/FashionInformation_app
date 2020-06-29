class Note < ApplicationRecord

  # アソシエーション
  belongs_to :user
  attachment :post_image

  # バリデーション
  validates :note_title, presence: true
  validates :note_body, presence: true

end
