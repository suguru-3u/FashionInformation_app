class Notice < ApplicationRecord
  # バリデーション
  validates :announce_title, presence: true
  validates :announce_body, presence: true

  # 最近のお悩み情報の取得の方法
  scope :recent, -> { order(created_at: "DESC") }

  # 検索メゾット
  def self.search(search)
    return Notice.all unless search
    Notice.where(['announce_title LIKE ?', "%#{search}%"])
  end
end
