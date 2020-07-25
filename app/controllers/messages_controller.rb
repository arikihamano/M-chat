# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    # チャット相手の情報を取得する
    @chat_room = ChatRoom.find_by(id: params[:id])
    if @chat_room.chat_room_users.find_by(user_id: current_user.id)
      @chat_room_user = @chat_room.chat_room_users
                                  .where.not(user_id: current_user.id).first.user
      @chat_messages = ChatMessage.where(chat_room_id: @chat_room).order(:created_at)
    else
      redirect_to users_path
    end
  end

  def create
    @chat_message = ChatMessage.new
    @chat_message.user_id = current_user.id
    @chat_message.chat_room_id = params[:id]
    @chat_message.message = params[:content]
    @chat_message.save

    SendMessageJob.perform_later(@chat_message)
  end

end
