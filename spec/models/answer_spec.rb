require 'rails_helper'

RSpec.describe 'Answerモデルのテスト', type: :model do
  describe 'Answerテスト' do
    before do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post,user_id: user.id)
      comment = post.comments.new(content: 'test',user_id: user.id)
      comment.save
      @answer = Answer.new(comment_id: comment.id, user_id: user.id)
      @answer.save
    end
    context '全てのカラムに値が入る' do
      it "保存される" do
        expect(@answer).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Answer.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Answerモデルとの関係' do
      it '1:Nとなっている' do
        expect(Answer.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end

  end

end
