require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    user = FactoryBot.create(:user_tanaka)
  end
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
        fill_in '自己紹介文を入力してください（任意）', with: "こんにちは"


        sleep 2
        click_button 'はじめる'

        expect(page).to have_content 'ユーザー一覧'
        expect(page).not_to have_content 'アカウントを作成'

        sleep 5
      end
    end

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

        sleep 2

        visit "/users/2"

        sleep 3
        visit "/users/edit"

        fill_in 'name-edit', with: "統合　花子"
        fill_in 'selfintroduction-edit', with: "よろしくお願いします！"
        attach_file 'profile_picture-edit', "#{Rails.root}/spec/fixtures/example2.jpg"
        fill_in 'password-edit', with: "password"
        sleep 2
        click_button '更新'
        expect(page).to have_content 'ユーザー一覧'
        expect(page).not_to have_content 'アカウント編集'
        sleep 5
      end
    end

    context "サインアウト、サインインができる" do
      it "サインアウト、サインインができること" do

        visit "/users/sign_up"
        attach_file 'profile_picture', "#{Rails.root}/spec/fixtures/example.jpg"
        fill_in '名前を入力してください', with: "統合　太郎"
        fill_in 'emailを入力してください', with: "integration@example.com"
        fill_in 'パスワードを入力してください', with: "password"
        fill_in 'パスワードを再度入力してください', with: "password"
        fill_in '自己紹介文を入力してください（任意）', with: "こんにちは"

        sleep 2
        click_button 'はじめる'

        sleep 2

        visit "/users/2"

        sleep 3
        find('#signout-btn').click

        expect(page).to have_content 'M chatを始めよう！'

        sleep 3
      end
    end
  end

  describe '異常' do
    context "必須項目が未入力" do
      it "エラーメッセージが表示され、回答できないこと" do
        visit "/users/sign_up"
        sleep 2
        click_button 'はじめる'

        expect(page).not_to have_content 'ユーザー一覧'
        expect(page).to have_content 'アカウントを作成'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワードを入力してください'
        expect(page).to have_content 'プロフィール画像を入力してください'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content '確認用パスワードを入力してください'
        sleep 5
      end
    end

    context "編集にはパスワードが必要であること" do
      it "パスワードの入力がなければ登録情報を変更できないこと" do

        visit "/users/sign_up"
        attach_file 'profile_picture', "#{Rails.root}/spec/fixtures/example.jpg"
        fill_in '名前を入力してください', with: "統合　太郎"
        fill_in 'emailを入力してください', with: "integration@example.com"
        fill_in 'パスワードを入力してください', with: "password"
        fill_in 'パスワードを再度入力してください', with: "password"
        fill_in '自己紹介文を入力してください（任意）', with: "こんにちは"

        sleep 2
        click_button 'はじめる'

        sleep 2

        visit "/users/2"

        sleep 3
        visit "/users/edit"

        fill_in 'name-edit', with: "統合　花子"
        fill_in 'selfintroduction-edit', with: "よろしくお願いします！"
        attach_file 'profile_picture-edit', "#{Rails.root}/spec/fixtures/example2.jpg"
        sleep 2
        click_button '更新'
        expect(page).to_not have_content 'M chatを始めよう！'
        expect(page).to have_content 'アカウント編集'
        sleep 5
      end
    end
  end
end
