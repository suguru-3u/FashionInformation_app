require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  before do
  	visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit users_posts_path
  end
  describe '投稿テスト' do
		context '投稿フォームに遷移' do
		  it 'タイトルと表示される' do
	    	expect(page).to have_content 'タイトル'
		  end
      it '本文と表示される' do
	    	expect(page).to have_content '本文'
		  end
		  it 'titleフォームが表示される' do
		  	expect(page).to have_field 'post[title]'
		  end
		  it 'post_imageフォームが表示される' do
		  	expect(page).to have_field 'post[post_image]'
		  end
      it 'post_bodyフォームが表示される' do
		  	expect(page).to have_field 'post[post_body]'
		  end
		  it '投稿する ボタンが表示される' do
		  	expect(page).to have_button '投稿する'
		  end
		  it '投稿に成功する' do
		  	fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
		  	fill_in 'post[post_body]', with: Faker::Lorem.characters(number:20)
		  	click_button '投稿する'
		  	expect(page).to have_content '投稿'
		  end
		  it '投稿に失敗する' do
		  	click_button '投稿する'
		  	expect(page).to have_content 'エラー'
		  end
		end
  end

  describe '編集のテスト' do
    before do
    	visit edit_users_post_path(post)
    end
  	context '自分の投稿の編集画面への遷移' do
  	  it '遷移できる' do
	  		expect(current_path).to eq('/users/' + 'posts/' + post.id.to_s + '/edit')
	  	end
	  end
		context '表示の確認' do
			it 'タイトルと表示される' do
				expect(page).to have_content('タイトル')
			end
			it 'title編集フォームが表示される' do
				expect(page).to have_field 'post[title]', with: post.title
			end
      it 'post_body編集フォームが表示される' do
        expect(page).to have_field 'post[post_body]', with: post.post_body
      end
			it '保存ボタンが表示される' do
				expect(page).to have_button '保存'
			end
			it '戻るリンクが表示される' do
				expect(page).to have_link '戻る', href: users_posts_path
			end
		end
		context 'フォームの確認' do
			it '編集に成功する' do
				click_button '保存'
				expect(page).to have_content '変更'
				expect(current_path).to eq '/users/' + 'posts'
			end
			it '編集に失敗する' do
				fill_in 'post[title]', with: ''
				click_button '保存'
				expect(page).to have_content 'エラー'
				expect(current_path).to eq('/users/' + 'posts/' + post.id.to_s )
			end
		end
	end

end
