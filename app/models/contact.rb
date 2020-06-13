class Contact < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :title, presence: true
  validates :contact_body, presence: true

end
