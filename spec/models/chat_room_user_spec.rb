require 'rails_helper'

RSpec.describe ChatRoomUser, type: :model do
  before do
    user_tanaka = User.new(
      name: '田中　太郎',
      email: 'taro.tanaka@example.com',
      self_introduction: 'こんにちは',
      password: 'password',
      img_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'))
    )

    user_tanaka.save

    chat_room_1 = ChatRoom.new()
    chat_room_1.save
  end

  describe "正常系の機能" do
    context 'ルームを作成する' do
      it '正しくルームとの紐付けを作成できること' do
        chat_room_user = FactoryBot.build(:chat_room_user)
        expect(chat_room_user).to be_valid
        chat_room_user.save
      end
    end
  end

  describe "入力項目の有無" do
    context '必須項目であること' do
      it 'チャットルームIDが必須であること' do
        new_chat_room_user = ChatRoomUser.new(chat_room_id: 1)
        expect(new_chat_room_user).not_to be_valid
      end
      it 'ユーザーIDが必須であること' do
        new_chat_room_user = ChatRoomUser.new(user_id: 1)
        expect(new_chat_room_user).not_to be_valid
      end
      it '登録できないこと' do
        new_chat_room_user = ChatRoomUser.new
        expect(new_chat_room_user.save).to be_falsey
      end
    end
  end

  describe "データ作成時の条件" do
    context "ユーザーとチャットルームの組み合わせの一意性を確認すること" do
      before do
        FactoryBot.create(:chat_room_user)

        chat_room_2 = ChatRoom.new()
        chat_room_2.save

        user_yamada = User.new(
          name: '山田　花子',
          email: 'hanako.yamada@example.com',
          self_introduction: 'こんにちは',
          password: 'password',
          img_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'))
        )
        user_yamada.save
      end
      it '同じユーザーとチャットルームの組み合わせの重複データは作成できないこと' do
        chat_room_user_again = ChatRoomUser.new(
          chat_room_id: 1,
          user_id: 1
        )
        expect(chat_room_user_again).to_not be_valid
        expect(chat_room_user_again.save).to be_falsey
      end

      it '同じチャットルームでも別のユーザーであればデータの作成ができること' do
        chat_room_user2 = ChatRoomUser.new(
          chat_room_id: 1,
          user_id: 2
        )

        expect(chat_room_user2).to be_valid
        expect(chat_room_user2.save).to be_truthy
      end

      it '同じユーザーでも別のチャットルームであればデータの作成ができること' do
        chat_room_user2 = ChatRoomUser.new(
          chat_room_id: 2,
          user_id: 1
        )

        expect(chat_room_user2).to be_valid
        expect(chat_room_user2.save).to be_truthy

      end

      it '別のユーザーで別のチャットルームであればデータの作成ができること' do
        chat_room_user2 = ChatRoomUser.new(
          chat_room_id: 2,
          user_id: 2
        )

        expect(chat_room_user2).to be_valid
        expect(chat_room_user2.save).to be_truthy
      end
    end
  end
end
