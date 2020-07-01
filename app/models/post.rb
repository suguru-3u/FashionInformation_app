class Post < ApplicationRecord
  # アソシエーション
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  attachment :post_image

  # バリデーション
  validates :title, presence: true
  validates :post_body, presence: true

  # 最近のお悩み情報の取得の方法
  scope :recent, -> { order(created_at: "DESC") }

  # post情報取得scope
  scope :recent_post, -> { order(answer_point: "DESC").limit(3) }

  # お気に入りしているのかチェックメゾット
  def favorites_user(user_id, post_id)
    Favorite.where(user_id: user_id, post_id: post_id).exists?
  end

  # good_answerしているのかのチェックメゾット
  def answers_user(user_id, cooment_id)
    Answer.where(user_id: user_id, cooment_id: cooment_id).exists?
  end

  # 検索メゾット
  def self.search(search)
    return Post.all unless search
    Post.where(['title LIKE ?', "%#{search}%"])
  end
end
