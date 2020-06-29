require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do

  describe '投稿テスト' do
    before do
      user = FactoryBot.create(:user)
      @post = user.posts.build(
        title: 'test' ,
        post_body: 'test@gamil.com',
        solution: false
      )
      @post.save
    end
    context '全てのカラムに値が入る' do
      it "保存される" do
        expect(@post).to be_valid
      end
    end
  end

  describe 'バリデーションのテスト' do
    let(:post) { build(:post) }
    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        post.save
        expect(post).to  be_invalid
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        post.post_body = ''
        post.save
        expect(post).to  be_invalid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoritetモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

  end
end
