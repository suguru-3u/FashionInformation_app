class Post < ApplicationRecord

    # アソシエーション
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
  	belongs_to :user
    attachment :post_image

    # バリデーション
    validates :title, presence: true
    validates :post_body, presence: true

    # お気に入りしているのかチェックメゾット
    def favorites_user(user_id, post_id)
		    Favorite.where(user_id: user_id, post_id: post_id).exists?
    end

    # 検索メゾット
    def self.search(search)
      return Post.all unless search
      Post.where(['title LIKE ?', "%#{search}%"])
    end

end
