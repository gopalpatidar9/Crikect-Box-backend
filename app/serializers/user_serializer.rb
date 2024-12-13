class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :mobilephone

  has_one :user_detail
  has_one :wallet
  has_many :transactions
  has_many :bets
  has_many :carts
  has_many :chat_rooms
  has_many :messages

end
