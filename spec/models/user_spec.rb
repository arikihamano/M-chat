require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系の機能' do
    context 'ユーザー登録する' do
      it '正しくユーザー登録できること' do
        user = FactoryBot.build(:user_tanaka)
        expect(user).to be_valid
        # userが正しく作成できたら保存するテストも書く
        
        # put user
        
        user.save

        # #保存したデータが正しいかどうかを確かめるテスト
        expect(user.name).to eq("田中　太郎")
        expect(user.email).to eq("taro.tanaka@example.com")
        expect(user.self_introduction).to eq("こんにちは")
        expect(user.password).to eq("password")
        expect(user.img_name.path).to eq("/Users/arikihamano/Desktop/M-chat/M-chat/public/uploads/user/img_name/1/example.jpg")
      end
    end
  end
  describe "入力項目の有無" do
    let(:new_user) {User.new}
    context "必須項目であること" do
      it "すべて空欄で保存しようとしたときエラーとなること" do
        expect(new_user).not_to be_valid
        expect(new_user.errors[:name]).to include(I18n.t('errors.messages.blank'))
        expect(new_user.errors[:email]).to include(I18n.t('errors.messages.blank'))
        expect(new_user.errors[:img_name]).to include(I18n.t('errors.messages.blank'))
        expect(new_user.errors[:encrypted_password]).to include(I18n.t('errors.messages.blank'))
      end

      it "登録できないこと" do
        expect(new_user.save).to be_falsey
      end
    end

  #   context '任意入力であること' do
  #     it '自己紹介は任意入力であること' do
  #       expect(new_user).not_to be_valid
  #       expect(new_user.errors[:self_introduction]).not_to include(I18n.t('errors.messages.blank'))
  #     end
  #   end
  end

  # describe "ユーザー登録時の条件" do
  #   context "メールアドレスを確認すること" do
  #     before do
  #       FactoryBot.create(:user_tanaka)
  #     end
  #     it '同じメールアドレスで再び登録できないこと' do

  #       user2 = FactoryBot.build(:user_tanka, self_introduction: "ハロー")
  #       expect(user2).not_to be_valid
  #       expect(user2.errors[:email]).to include(I18n.t('errors.messages.taken'))
  #       expect(user2.save).to be_falsey
  #       expect(User.all.size).to eq 1
  #     end
  #     it '異なるメールアドレスでは再び登録できること' do
  #       user_yamada = FactoryBot.build(:user_yamada)

  #       expect(user_yamada).to be_valid
  #       user_yamada.save
  #       expect(User.all.size).to eq 2
  #     end
  #   end
  # end

  # describe "メールアドレスの形式" do
  #   context "不正な形式のメールアドレスの場合" do
  #     it 'エラーになること' do
  #       new_user = User.new
  #       new_user.email = "taro.tanaka"
  #       expect(new_user).not_to be_valid
  #       expect(new_user.errors[:email]).to include(I18nt.t('errors.messages.invalid'))
  #     end
  #   end  
  # end
  
  
end

