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
      end
    end
  end
end
