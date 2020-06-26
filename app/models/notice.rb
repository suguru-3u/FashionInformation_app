class Notice < ApplicationRecord

  # バリデーション
  validates :announce_title, presence: true
  validates :announce_body, presence: true

end
