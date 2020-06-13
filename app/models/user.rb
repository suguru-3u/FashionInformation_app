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
  has_many :favorites, dependent: :destroy
  has_many :favorites_post, through: :favorites, source: :post

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true

  # enum設定
  enum sex_status: {neither: 0, men: 1, women: 2}

  # GoogleAPIメゾット
  protected
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.create(name:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         email:    auth.info.email,
                         password: Devise.friendly_token[0, 20],
                         meta:     auth.to_yaml)
    end
    user
  end

end
