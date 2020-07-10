import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const chat_room_element = document.getElementById("chat_room-id");
  const chat_room_id = Number(
    chat_room_element.getAttribute("data-chat_room-id")
  );
  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_room_id: chat_room_id },
    {
      connected() {
        console.log("connected to" + chat_room_id);
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log(data);
        const user_element = document.getElementById("user-id");
        const user_id = Number(user_element.getAttribute("data-user-id"));
        // 以下はメッセージの送信者によって、クラスを付与してメッセージの配置を変更する場合
        // let html;

        // if (user_id === data.message.user_id) {
        //   html = data.mine
        // } else {
        //   html = data.theirs
        // }

        const messageContainer = document.getElementById("chat-messages");
        messageContainer.innerHTML = messageContainer.innerHTML + data.html;
      },

      speak: function () {
        return this.perform("speak");
      },
    }
  );
});
