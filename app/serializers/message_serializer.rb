class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :chat_room_id

  # belongs_to :chat_room, serializer: ChatRoomSerializer 
  # belongs_to :user, serializer: UserSerializer
end
