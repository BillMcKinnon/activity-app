class PasswordResetsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase.strip)

    if user
      user.send_password_reset
      flash[:success] = "Password reset instructions have been sent to your inbox."
      redirect_to root_path
    else
      flash[:danger] = "Email not found."
      render 'new'
    end
  end

  def new

  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      flash[:danger] = 'Password reset has expired'
      redirect_to new_password_reset_path
    elsif @user.update(user_params)
      flash[:success] = 'Password has been reset!'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password)
    end

end

