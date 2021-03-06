class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable, omniauth_providers: %i(google)

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :youtubes, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comments_post, through: :comments, source: :post
  has_many :favorites, dependent: :destroy
  has_many :favorites_post, through: :favorites, source: :post
  has_many :notes, dependent: :destroy
  has_many :answers, dependent: :destroy

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true

  # 最近のお悩み情報の取得の方法
  scope :recent, -> { order(created_at: "DESC") }

  # post情報取得scope
  scope :recent_post, -> { order(answer_point: "DESC").limit(3) }

  # GoogleAPIメゾット

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
    user ||= User.create(
      name: auth.info.name,
      provider: auth.provider,
      uid: auth.uid,
      token: auth.credentials.token,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      meta: auth.to_yaml
    )
    user
  end

  # 検索メゾット
  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end
end
