require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        user.save
        expect(user).to  be_invalid
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        user.save
        expect(user).to  be_invalid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Youtubeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:youtubes).macro).to eq :has_many
      end
    end

    context 'Contactモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:contacts).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoritetモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Answerモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:answers).macro).to eq :has_many
      end
    end

  end
end
