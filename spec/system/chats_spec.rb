require 'rails_helper'

RSpec.describe "FoodEnquetes", type: :system do
  before do
    user = FactoryBot.create(:user_tanaka)
  end

  describe '正常' do
    context "チャットルームを作成、チャット送信" do
      it "チャットルームを作成、メッセージを送信できること" do
        visit "/users/sign_up"
        attach_file 'profile_picture', "#{Rails.root}/spec/fixtures/example.jpg"
        fill_in '名前を入力してください', with: "統合　テスト"
        fill_in 'emailを入力してください', with: "integration@example.com"
        fill_in 'パスワードを入力してください', with: "password"
        fill_in 'パスワードを再度入力してください', with: "password"
        fill_in '自己紹介文を入力してください（任意）', with: "こんにちは"


        sleep 2
        click_button 'はじめる'

        sleep 2

        expect(page).to have_content 'ユーザー一覧'
        expect(page).not_to have_content 'アカウントを作成'

        sleep 2

        click_button "チャットを開く"

        sleep 2

        expect(page).to have_content '田中　太郎'

        fill_in 'Type your message here...', with: "Hello!"

        sleep 3

        click_button "Add Message"

        sleep 3

        fill_in 'Type your message here...', with: "Hello!"

        sleep 3

        click_button "Add Message"


        sleep 3

        visit '/messages/1'

        expect(page).to have_content 'Hello!'
        sleep 5

      end
    end
  end
end
