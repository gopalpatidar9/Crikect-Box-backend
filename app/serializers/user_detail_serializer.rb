class UserDetailSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :profilepicture, :deposit_request_enabled, :chats_enabled, :can_add_user, :bet_enabled, :user_id

  # belongs_to :user #, serializer: UserSerializer
end
