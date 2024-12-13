class UserDetail < ApplicationRecord
  belongs_to :user
  # belongs_to :paren_user , class_name: 'User' , optional:true
  has_one_attached :profilepicture
end
