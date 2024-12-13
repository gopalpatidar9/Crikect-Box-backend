class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_user!  

  def create
    chat_room = ChatRoom.find(params[:chat_room_id])
    message = chat_room.messages.build(content: params[:content], user: current_user)

    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :unprocessable_entity  
    end
  end
end
