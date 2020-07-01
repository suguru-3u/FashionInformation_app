require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '会員登録'

        expect(page).to have_content 'ホーム'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '会員登録'

        expect(page).to have_content 'error'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'ログイン'

        expect(page).to have_content 'ホーム'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  let!(:post) { create(:post, user: user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  describe 'headerのテスト' do
    context '表示の確認' do
      it 'お悩み投稿と表示される' do
        expect(page).to have_content('お悩み投稿')
      end
      it 'Youtubeが表示される' do
        expect(page).to have_content('Youtube')
      end
      it 'ユーザー情報が表示される' do
        expect(page).to have_content('ユーザー情報')
      end
      it 'お知らせが表示される' do
        expect(page).to have_content('お知らせ')
      end
      it 'お問い合わせが表示される' do
        expect(page).to have_content('お問い合わせ')
      end
      it 'ログアウトが表示される' do
        expect(page).to have_content('ログアウト')
      end
    end
  end

  describe '編集のテスト' do
    context 'ユーザー情報画面への遷移' do
      it '遷移できる' do
        visit users_users_path
        expect(page).to have_content('マイページ')
      end
    end

    context '表示の確認' do
      before do
        visit users_users_path
      end
      it 'ユーザー情報と表示される' do
        expect(page).to have_content('ユーザー情報')
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '名前編集フォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end

      it '編集に成功する' do
        click_button '変更する'
        expect(page).to have_content 'ユーザー情報の変更が完了しました'
      end
    end
  end

  describe '一覧画面のテスト' do
    before do
      visit users_users_path
    end
    context '表示の確認' do
      it '投稿したお悩みと表示される' do
        expect(page).to have_content('投稿したお悩み')
      end
      it 'お悩み一覧の画像が表示される' do
        expect(all('img').size).to eq(1)
      end
      it 'お悩み一覧が表示される' do
        expect(page).to have_content post.title
        expect(page).to have_content post.created_at.to_s(:datetime_jp)
        expect(page).to have_content post.comments.count
      end
      it 'リンクが表示される' do
        expect(page).to have_link 'お悩みを解決する', href: users_post_path(post)
        expect(page).to have_link '編集', href: edit_users_post_path(post)
        expect(page).to have_link '削除', href: users_post_path(post)
      end
    end
  end
end
