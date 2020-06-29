class Contact < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :title, presence: true
  validates :contact_body, presence: true

  # 最近のお悩み情報の取得の方法
  scope :recent, -> { order(created_at: "DESC") }

  # 検索メゾット
  def self.search(search)
    return Contact.all unless search
    Contact.where(['title LIKE ?', "%#{search}%"])
  end

end
