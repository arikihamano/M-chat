require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
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
    context "メッセージを作成する" do
      it "正しくメッセージを作成できること" do
        message = ChatMessage.new(
          chat_room_id: 1,
          user_id: 1,
          message: "Hello!"
        )
        expect(message).to be_valid
        message.save

        created_message =  ChatMessage.find(1)
        expect(created_message.chat_room_id).to eq(1)
        expect(created_message.user_id).to eq(1)
      end
    end
  end

  describe "必須項目の有無" do
    context "それぞれの項目が必須であること" do
      it "ユーザーIDが必須であること" do
        new_message = ChatMessage.new(
          chat_room_id: 1,
          message: "Hello!"
        )
        expect(new_message).not_to be_valid
      end
      it "チャットルームIDが必須であること" do
        new_message = ChatMessage.new(
          user_id: 1,
          message: "Hello!"
        )
        expect(new_message).not_to be_valid
      end
      it "メッセージ内容が必須であること" do
        new_message = ChatMessage.new(
          chat_room_id: 1,
          user_id: 1,
        )
        expect(new_message).not_to be_valid
      end
      it "空文字のメッセージではないこと" do
        new_message = ChatMessage.new(
          chat_room_id: 1,
          user_id: 1,
          message: ""
        )
        expect(new_message).not_to be_valid
      end
      it "要件を満たさないメッセージは作成できないこと" do
        new_message = ChatMessage.new
        expect(new_message.save).to be_falsey
      end
    end
  end
end
