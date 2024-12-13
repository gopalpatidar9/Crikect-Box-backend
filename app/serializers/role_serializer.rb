class RoleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name 

  # has_many :user_roles  #, serializer: UserRoleSerializer
end
