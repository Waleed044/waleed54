class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
    def welcome_email(user)
        @user = user
        @url  = "http://127.0.0.1:3000/users/sign_in"
        mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end
