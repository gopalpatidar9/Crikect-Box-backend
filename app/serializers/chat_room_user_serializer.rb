class ChatRoomUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :chat_room_id

  # belongs_to :user, serializer: UserSerializer

  # belongs_to :chat_room, serializer: ChatRoomSerializer
end
