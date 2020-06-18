class Comment < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :post
  has_many :answers, dependent: :destroy

  # バリデーション
  validates :content, presence: true

end
