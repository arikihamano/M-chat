require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe '正常' do
    context "ユーザー登録する" do
      it "登録できること" do
        #factorybotのデータを読み込もうとすると既にメールアドレスが存在するとなってしまうので直接入力"
        visit "/users/sign_up"
        attach_file 'profile_picture', "#{Rails.root}/spec/fixtures/example.jpg"
        fill_in '名前を入力してください', with: "統合　テスト"
        fill_in 'emailを入力してください', with: "integration@example.com"
        fill_in 'パスワードを入力してください', with: "password"
        fill_in 'パスワードを再度入力してください', with: "password"

        sleep 2
        click_button 'はじめる'

        # [Point.6-2-8]回答が完了したか検証します。
        expect(page).to have_content 'ユーザー一覧'
        expect(page).not_to have_content 'アカウントを作成'

        sleep 5
      end
    end
  end
end
