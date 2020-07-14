import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  window.messageContent = document.getElementById("content");

  // ********** 以下を追加 **********
  const messageButton = document.getElementById("message-button");

  // 空欄でなければボタンを有効化，空欄なら無効化する関数
  const button_activation = () => {
    if (messageContent.value === "") {
      messageButton.classList.add("disabled");
    } else {
      messageButton.classList.remove("disabled");
    }
  };

  // フォームに入力した際の動作
  messageContent.addEventListener("input", () => {
    button_activation();
  });

  // 送信ボタンが押された時にボタンを無効化
  messageButton.addEventListener("click", () => {
    messageButton.classList.add("disabled");
  });
  // ********** 以上を追加 **********

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
        let html;

        if (user_id === data.chat_message.user_id) {
          html = data.mine;
        } else {
          html = data.theirs;
        }

        const messageContainer = document.getElementById("chat-messages");
        messageContainer.innerHTML = messageContainer.innerHTML + html;
      },

      speak: function () {
        return this.perform("speak");
      },
    }
  );
});
