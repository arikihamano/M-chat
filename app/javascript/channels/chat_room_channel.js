import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  window.messageContent = document.getElementById("content");

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
    // ボタンを有効化する
    button_activation();
  });
  const documentElement = document.documentElement;

  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight);
    messageContainer.scroll(0, messageContainer.scrollHeight);
  };

  // 送信ボタンが押された時にボタンを無効化
  messageButton.addEventListener("click", () => {
    messageButton.classList.add("disabled");
  });

  // サブスクリプションのためのデータ取得
  const chat_room_element = document.getElementById("chat_room-id");
  const chat_room_id = Number(
    chat_room_element.getAttribute("data-chat_room-id")
  );

  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_room_id: chat_room_id },
    {
      connected() {
        console.log("connected to" + chat_room_id);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log(data);
        const user_element = document.getElementById("user-id");
        const user_id = Number(user_element.getAttribute("data-user-id"));

        let html;

        if (user_id === data.chat_message.user_id) {
          html = data.mine;
        } else {
          html = data.theirs;
        }

        const messageContainer = document.getElementById("chat-messages");
        messageContainer.innerHTML = messageContainer.innerHTML + html;
        if (user_id === data.chat_message.user_id) {
          // もしチャットの送信者が本人であればページを下までスクロールする
          window.messageContainer = document.getElementById("chat-messages");
          scrollToBottom();
        } else {
          // もしチャットの送信者が相手であれば下までスクロールしない
        }
      },

      speak: function () {
        return this.perform("speak");
      },
    }
  );
});
