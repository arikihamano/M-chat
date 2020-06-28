class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for "chat_room_#{params[:room_id]}"
  end

  def unsubscribed
    # Any clkanup needed when channel is unsubscribed
  end

  def speak(data)
    message = ChatMessage.create(chat_room_id: data['room_id'], user_id: data['user_id'], message: data['message'])
    ChatRoomChannel.broadcast_to "chat_room_#{data['room_id']}", content: render_message(message)
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'chat_messages/chat_message', locals: { chat_message: message, current_user: message.user })
    end
end
