require 'rails_helper'
RSpec.describe Post, type: :request do
    describe 'アプリの紹介ページ' do
        context "Topページが正しく表示される" do
            before do
                get root_path
            end
            it 'リクエストは200 OKとなること' do
                expect(response.status).to eq 200
            end
            it 'タイトルが正しく表示されていること' do
                expect(response.body).to include("今日何を来ていけばいいのかわからなくなる時がありませんか")
            end
        end
        context "Aboutページが正しく表示される" do
            before do
                get users_homes_about_path
            end
            it 'リクエストは200 OKとなること' do
                expect(response.status).to eq 200
            end
            it 'タイトルが正しく表示されていること' do
                expect(response.body).to include("ようこそFashionInformation_appへ")
            end
        end
    end
end
