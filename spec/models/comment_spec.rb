require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do

  describe 'コメントテスト' do
    before do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post,user_id: user.id)
      @comment = post.comments.new(content: 'test',user_id: user.id)
      @comment.save
    end
    context '全てのカラムに値が入る' do
      it "保存される" do
        expect(@comment).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do

    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Answerモデルとの関係' do
      it '1:Nとなっている' do
        expect(Comment.reflect_on_association(:answers).macro).to eq :has_many
      end
    end

  end

end
