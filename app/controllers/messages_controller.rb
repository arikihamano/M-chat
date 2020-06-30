class MessagesController < ApplicationController

  def show
    # チャット相手の情報を取得する
    chat_room = ChatRoom.find_by(id: params[:id])
    @chat_room_user = chat_room.chat_room_users.
      where.not(user_id: current_user.id).first.user
    @message = ChatMessage.new
    @chat_messages = ChatMessage.where(chat_room: chat_room).order(:created_at)
  end

  def create
    @message = ChatMessage.new(message_params)
    @message.user_id = current_use.id
    @message.after_save

    ActionCable.server.broadcast "room_channel_#{@message.room_id}", message: "hello"
  end
end
