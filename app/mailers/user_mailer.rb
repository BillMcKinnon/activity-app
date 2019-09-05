class UserMailer < ApplicationMailer
  default from: "billsactivityapp@gmail.com"

  def account_activation(user)
    @user = user

    mail to: user.email, subject: "Activity App Account Activation"
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Activity App Password Reset"
  end
end
