class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # deviseのときはこっち？
    # html = ApplicationController.render_with_signed_in_user(
    html = ApplicationController.render(
      partial: 'message',
      locals: { chat_message: @chat_message }
    )

    ActionCable.server.broadcast "room_channel_#{chat_message.chat_room_id}", html: html
  end
end
