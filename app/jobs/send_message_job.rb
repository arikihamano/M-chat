class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # deviseのときはApplicationController.renderではなく、ApplicationController.render_with_signed_in_userを使う
    mine = ApplicationController.render_with_signed_in_user(
      chat_message.user,
      partial: 'messages/mine',

      locals: { chat_message: chat_message }
    )

    theirs = ApplicationController.render_with_signed_in_user(
      chat_message.user,
      partial: 'messages/theirs',

      locals: { chat_message: chat_message }
    )

    ActionCable.server.broadcast "room_channel_#{chat_message.chat_room_id}", mine: mine, theirs: theirs, chat_message: chat_message
  end
end
