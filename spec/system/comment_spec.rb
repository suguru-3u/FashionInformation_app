require 'rails_helper'

describe 'コメントのテスト' do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  before do
  	visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit users_posts_path
    click_link 'お悩みを解決する'
  end
  describe '投稿テスト' do
		context '投稿フォームに遷移' do
		  it 'コメントと表示される' do
	    	expect(page).to have_content 'コメント'
		  end
		  it '投稿 ボタンが表示される' do
		  	expect(page).to have_button '投稿'
		  end
		  it '投稿に成功する' do
		  	fill_in 'comment[content]', with: Faker::Lorem.characters(number:5)
		  	click_button '投稿'
		  	expect(page).to have_content 'コメント投稿を投稿しました'
		  end
		  it '投稿に失敗する' do
		  	click_button '投稿'
		  	expect(page).to have_content 'コメント投稿に失敗しました'
		  end
      it '投稿を削除する' do
        fill_in 'comment[content]', with: Faker::Lorem.characters(number:5)
		  	click_button '投稿'
		  	click_link '削除'
		  	expect(page).to have_content 'コメント削除しました'
		  end
      it 'お悩みを解決する' do
        fill_in 'comment[content]', with: Faker::Lorem.characters(number:5)
		  	click_button 'お悩み解決'
		  	expect(page).to have_content '投稿内容を変更しました'
		  end
		end
  end
end
