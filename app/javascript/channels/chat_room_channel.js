
import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: roomId }, {
  received(data) {
    const messageElement = document.createElement('p');
    messageElement.innerHTML = `<strong>${data.user.name}:</strong> ${data.content}`;

    const chatBox = document.getElementById('chat-box');
    if (chatBox) {
      chatBox.appendChild(messageElement);
    }
  }
});

