class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates :content, presence: true

  after_create_commit { broadcast_message }

  def broadcast_message
    ChatRoomChannel.broadcast_to(chat_room, self)
  end
end
