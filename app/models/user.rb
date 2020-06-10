class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true

  # enum設定
  enum sex_status: {neither: 0, men: 1, women: 2}

end
