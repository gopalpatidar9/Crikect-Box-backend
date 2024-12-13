class Api::V1::AddUsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_superadmin!
  protect_from_forgery with: :null_session

  def index
  end
  
  def add_new_user
    role_name = current_user.user_role.role.name
  
    case role_name
    when 'SuperAdmin'
      create_user_with_role('Admin', 'admin123')
    when 'Admin'
      create_user_with_role('User', 'user123')
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
  
  def create_user_with_role(role_name, default_password)
    role = Role.find_by(name: role_name)
    parent_user_id = current_user.id
    new_user = User.new(
      name: params[:name],
      email: params[:email],
      mobilephone: params[:mobilephone],
      username: params[:username],
      parent_user_id: parent_user_id
    )
    new_user.password = default_password
    new_user.password_confirmation = default_password
  
    if new_user.save
      UserRole.create(user: new_user, role: role)
      Wallet.create(user_id: new_user.id, balance: 0)
      UserDetail.create(
        user_id: new_user.id,
        parentuserid: new_user.parent_user_id,
        deposit_request_enabled: true,
        chats_enabled: true,
        can_add_user: true,
        bet_enabled: true
      )
      chat_room = ChatRoom.create(name: "Chat between #{current_user.name} and #{new_user.name}")
      ChatRoomUser.create(chat_room: chat_room, user: current_user)
      ChatRoomUser.create(chat_room: chat_room, user: new_user)

      #UserMailer.welcome_email(new_user, default_password).deliver_now

      render json: { status: "#{role_name} created successfully", user: UserSerializer.new(new_user) }, status: :created
    else
      render json: { errors: new_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def users_list
    users = User.where(parent_user_id: current_user.id)
    if users.any?
      render json: users.as_json,  status: :ok
    else
      render json: {error: 'users not found'} , status: :not_found
    end
  end

  def my_users_user_detial
    user = User.find(params[:id])
    user_detail = user.user_detail
    if user_detail 
      render josn: user_detail, status: :ok
    else
      render json: {error: 'User Detial not found'}, status: :not_found
    end
  end

  def show_user_added_list
    user = User.find(params[:id])
    users = User.where(parent_user_id: user.id)

    if users.eny?
      render json: users, status: :ok
    else
      render json: {error: 'users not found'}, status: :not_found
    end
  end

  def show_chat_room
    user = User.find(params[:id])

    if user && user.parent_user_id == current_user.id
      chat_room = ChatRoom
                   .joins(:chat_room_participants)
                   .where(chat_room_participants: { user_id: [current_user.id, user.id] })
                   .group('chat_rooms.id')
                   .having('COUNT(chat_rooms.id) = 2') 

      render json: chat_room, each_serializer: ChatRoomSerializer, status: :ok
    else
      render json: { error: 'Unauthorized or user not found' }, status: :unauthorized
    end
  end

  def generate_password(length = 12)
    SecureRandom.alphanumeric(length)
  end

  def user_update
    user = User.find_by(id: params[:id])
    if user.parent_user_id == current_user.id
      user_detail = user.user_detail
      if user_detail.update(
          deposit_request_enabled: params[:deposit_request_enabled],
          chats_enabled: params[:chats_enabled],
          can_add_user: params[:can_add_user],
          bet_enabled: params[:bet_enabled]
        )
        render json: user_detail, status: :ok
      else
        render json: user_detail.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized user' }, status: :forbidden
    end
  end

  def show_user_detial
    user = User.find_by(id: parmas[:id])
    user_detail = user.user_detail
    render json: user_detail , status: :ok
  end

  private

end
