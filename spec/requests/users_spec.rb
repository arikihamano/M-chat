require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "正常" do
    it "ユーザー登録できること" do
      get "/users/sign_up"
      expect(response).to have_http_status(200)
      post "/users", params: { user: FactoryBot.attributes_for(:user_tanaka) }
      follow_redirect!
      expect(response).to have_http_status(200)
    end
  end
  describe '異常' do
    context "アンケートに回答する" do
      it "エラーメッセージが表示されること" do
        get "/users/sign_up"
        expect(response).to have_http_status(200)

        post "/users", params: { user: { name: '' } }
        expect(response.body).to include "ユーザ は保存されませんでした"
      end
    end
  end
end
