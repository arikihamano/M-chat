class MessagesController < ApplicationController

  require "pry"

  def show
    # チャット相手の情報を取得する
    chat_room = ChatRoom.find_by(id: params[:id])
    @chat_room_user = chat_room.chat_room_users.
      where.not(user_id: current_user.id).first.user
    @chat_messages = ChatMessage.where(chat_room: chat_room).order(:created_at)
    
    binding.pry
    
  end

  def create
    @chat_message = ChatMessage.new
    @chat_message.user_id = current_user.id # ここがフォームからきた値をモデルに移し替える
    @chat_message.chat_room_id = chat_room.id # ここは間違っているかもだが、そもそもフォームが表示できないので一度スキップ
    @chat_message.message = params[:content]
    @chat_message.save()
  end
end
