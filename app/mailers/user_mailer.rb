class UserMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def account_activation(user)
    @user = user

    mail to: user.email, subject: "Onward Account Activation"
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Onward Password Reset"
  end
end

