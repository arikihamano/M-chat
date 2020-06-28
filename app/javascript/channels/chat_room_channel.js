import consumer from "./consumer";

consumer.subscriptions.create(
  { channel: "ChatRoomChannel", chat_room_id: 1 },
  {
    connected() {
      console.log("connected!!!");
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
    },

    speak: function () {
      return this.perform("speak");
    },
  }
);
