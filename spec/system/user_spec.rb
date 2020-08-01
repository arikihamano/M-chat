require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe '正常' do
    # context "ユーザー登録する" do
    #   it "登録できること" do
    #     #factorybotのデータを読み込もうとすると既にメールアドレスが存在するとなってしまうので直接入力"
    #     visit "/users/sign_up"
    #     attach_file 'profile_picture', "#{Rails.root}/spec/fixtures/example.jpg"
    #     fill_in '名前を入力してください', with: "統合　テスト"
    #     fill_in 'emailを入力してください', with: "integration@example.com"
    #     fill_in 'パスワードを入力してください', with: "password"
    #     fill_in 'パスワードを再度入力してください', with: "password"
    #     fill_in '自己紹介文を入力してください（任意）', with: "こんにちは"


    #     sleep 2
    #     click_button 'はじめる'

    #     # [Point.6-2-8]回答が完了したか検証します。
    #     expect(page).to have_content 'ユーザー一覧'
    #     expect(page).not_to have_content 'アカウントを作成'

    #     sleep 5
    #   end
    # end

    context "ユーザー情報を編集する" do
      it "登録後、編集できること" do
        #factorybotのデータを読み込もうとすると既にメールアドレスが存在するとなってしまうので直接入力"
        visit "/users/sign_up"
        attach_file 'profile_picture', "#{Rails.root}/spec/fixtures/example.jpg"
        fill_in '名前を入力してください', with: "統合　太郎"
        fill_in 'emailを入力してください', with: "integration@example.com"
        fill_in 'パスワードを入力してください', with: "password"
        fill_in 'パスワードを再度入力してください', with: "password"
        fill_in '自己紹介文を入力してください（任意）', with: "こんにちは"

        sleep 2
        click_button 'はじめる'

        # [Point.6-2-8]回答が完了したか検証します。

        sleep 2

        visit "/users/1"

        sleep 3
        visit "/users/edit"

        #　ユーザー情報の更新のための入力はapp/views/devise/registrations/edit.html.erb入力フォームにidをつけて、こっちのfill_inではidを指定すること。パスワードの入力もこれで大丈夫なのではないだろうか
        #　更新ができたかの判別としては以下
        #　更新ができた場合、→ ユーザー一覧という文字が画面にある
        #　更新ができない場合、アカウント編集という文字が画面にある
        fill_in 'name-edit', with: "統合　花子"
        fill_in 'selfintroduction-edit', with: "よろしくお願いします！"
        attach_file 'profile_picture-edit', "#{Rails.root}/spec/fixtures/example2.jpg"
        fill_in 'password-edit', with: "password"
        sleep 2
        click_button '更新'
        expect(page).to have_content 'ユーザー一覧'
        expect(page).not_to have_content 'アカウントを作成'
        sleep 5
      end
    end
  end

  # describe '異常' do
  #   context "必須項目が未入力" do
  #     it "エラーメッセージが表示され、回答できないこと" do
  #       visit "/users/sign_up"
  #       sleep 2
  #       click_button 'はじめる'

  #       # [Point.6-2-8]回答が完了したか検証します。
  #       expect(page).not_to have_content 'ユーザー一覧'
  #       expect(page).to have_content 'アカウントを作成'
  #       expect(page).to have_content 'メールアドレスを入力してください'
  #       expect(page).to have_content 'パスワードを入力してください'
  #       expect(page).to have_content 'プロフィール画像を入力してください'
  #       expect(page).to have_content 'ユーザー名を入力してください'
  #       expect(page).to have_content '確認用パスワードを入力してください'
  #       sleep 5
  #     end
  #   end
  # end
end
