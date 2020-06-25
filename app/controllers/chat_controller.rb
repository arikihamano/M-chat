class ChatController < ApplicationController
  def create
    # 自分の持っているチャットルームを取得
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room)
    # 自分の持っているチャットルームからチャット相手のいるルームを探す
    chat_room = ChatRoomUser.where(chat_room: current_user_chat_rooms, user_id: params[:user_id]).map(&:chat_room).first
    # なければ作成する
    if chat_room.blank?
      # chat_roomsテーブルにレコードを作成
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room: chat_room, user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room, user_id: params[:user_id])
    end
    # チャットルームへ遷移させる
    redirect_to action: :show, id: chat_room.id
  end

  def show
    # チャット相手の情報を取得する
    chat_room = ChatRoom.find_by(id: params[:id])
    @chat_room_user = chat_room.chat_room_users.
      where.not(user_id: current_user.id).first.user
    @chat_messages = ChatMessage.where(chat_room: chat_room).order(:created_at)
  end
end
