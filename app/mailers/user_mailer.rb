class UserMailer < ApplicationMailer
  default from: 'gopalpatidara9@gmail.com' 

  def welcome_email(user, password)
    @user = user
    @password = password
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Our CricketBox!')
  end
end
