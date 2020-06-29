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
      console.log(data);
    },

    speak: function () {
      return this.perform("speak");
    },
  }
);
