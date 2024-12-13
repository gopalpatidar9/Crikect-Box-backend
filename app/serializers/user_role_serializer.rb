class UserRoleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :role_id

  # belongs_to :user, serializer: UserSerializer
  # belongs_to :role, serializer: RoleSerializer
end
