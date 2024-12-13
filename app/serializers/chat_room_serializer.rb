class ChatRoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name 

  # has_many :users  #, serializer: UserSerializer
  # has_many :messages  #, serializer: MessageSerializer
end
