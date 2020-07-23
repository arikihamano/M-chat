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
        # user_tanaka = User.new(
        #   name: '田中　太郎',
        #   email: 'taro.tanaka@example.com',
        #   self_introduction: 'こんにちは',
        #   password: 'password',
        #   img_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'))
        # )

        # user_tanaka.save

        # chat_room_1 = ChatRoom.new()
        # chat_room_1.save

        chat_room_user = ChatRoomUser.new(
          chat_room_id: 1,
          user_id: 1
        )
        expect(chat_room_user).to be_valid 

        chat_room_user.save
      end
    end
  end

  describe "入力項目の有無" do
    context '必須項目であること' do
      it 'チャットルームIDが必須であること' do
        # user_tanaka = User.new(
        #   name: '田中　太郎',
        #   email: 'taro.tanaka@example.com',
        #   self_introduction: 'こんにちは',
        #   password: 'password',
        #   img_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'))
        # )

        # user_tanaka.save

        # chat_room_1 = ChatRoom.new()
        # chat_room_1.save

        new_chat_room_user = ChatRoomUser.new(chat_room_id: 1)
        expect(new_chat_room_user).not_to be_valid  
        
      end
      it 'ユーザーIDが必須であること' do
        # user_tanaka = User.new(
        #   name: '田中　太郎',
        #   email: 'taro.tanaka@example.com',
        #   self_introduction: 'こんにちは',
        #   password: 'password',
        #   img_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'))
        # )

        # user_tanaka.save

        # chat_room_1 = ChatRoom.new()
        # chat_room_1.save

        new_chat_room_user = ChatRoomUser.new(user_id: 1)
        expect(new_chat_room_user).not_to be_valid
      end
      it '登録できないこと' do
        # user_tanaka = User.new(
        #   name: '田中　太郎',
        #   email: 'taro.tanaka@example.com',
        #   self_introduction: 'こんにちは',
        #   password: 'password',
        #   img_name: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'))
        # )

        # user_tanaka.save

        # chat_room_1 = ChatRoom.new()
        # chat_room_1.save

        new_chat_room_user = ChatRoomUser.new

        expect(new_chat_room_user.save).to be_falsey
      end
    end

    describe "データ作成時の条件" do
      context "ユーザーとチャットルームの組み合わせの一意性を確認すること" do
        it '同じユーザーとチャットルームの組み合わせの重複データは作成できないこと' do
          chat_room_user = ChatRoomUser.new(
            chat_room_id: 1,
            user_id: 1
          )
          expect(chat_room_user).to be_valid 
  
          chat_room_user.save

          chat_room_user_again = ChatRoomUser.new(
            chat_room_id: 1,
            user_id: 1
          )
          expect(chat_room_user_again).to_not be_valid
          expect(chat_room_user_again.save).to be_falsey
        end
      end
    end

  end
  

end
