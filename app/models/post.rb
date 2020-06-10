class Post < ApplicationRecord

    # アソシエーション
    has_many :comments
  	belongs_to :user
    attachment :post_image

    # バリデーション
    validates :title, presence: true
    validates :post_body, presence: true

end
