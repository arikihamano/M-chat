class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # html = ApplicationController.render(

    # deviseのときはこっち？
    html = ApplicationController.render_with_signed_in_user(
      chat_message.user,
      partial: 'messages/message',
    
      locals: { chat_message: chat_message }
    )

    ActionCable.server.broadcast "room_channel_#{chat_message.chat_room_id}", html: html
  end
end
