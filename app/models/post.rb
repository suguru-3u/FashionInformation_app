class Post < ApplicationRecord

    # アソシエーション
  	belongs_to :user
    attachment :post_image

    # バリデーション
    validates :title, presence: true
    validates :post_body, presence: true

end
