class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :recipient_id, :sender_id, :message, :notification_type,
  :is_read

  # belongs_to :recipient, serializer: UserSerializer
  # belongs_to :sender, serializer: UserSerializer
end
