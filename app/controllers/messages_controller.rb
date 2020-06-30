class MessagesController < ApplicationController
  def create
    @message = ChatMessage.new(message_params)
    @message.user_id = current_use.id
    @message.after_save
  
    ActionCable.server.broadcast "room_channel_#{@message.room_id}", message: "hello"
  end
end
