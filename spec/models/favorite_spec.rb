require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do

  describe 'お気に入りテスト' do
    before do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post,user_id: user.id)
      @post = user.favorites.new(post_id: post.id)
      @post.save
    end
    context '全てのカラムに値が入る' do
      it "保存される" do
        expect(@post).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do

    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

  end

end
