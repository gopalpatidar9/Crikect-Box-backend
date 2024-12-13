class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  # belongs_to :parent_user, class_name: 'User', optional: true, foreign_key: 'parent_user_id'

  has_one :user_role, dependent: :destroy
  has_one :role, through: :user_role
  has_one :user_detail, dependent: :destroy
  has_one :wallet, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :bets, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users, dependent: :destroy
  has_many :messages, dependent: :destroy

  def superuser?
    role&.name == 'SuperAdmin'
  end

  # # Method to check if a parent_user should be included
  # def should_include_parent_user?
  #   !superuser? && parent_user.present?
  # end
end
