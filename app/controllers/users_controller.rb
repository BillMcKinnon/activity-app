class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to activities_path
    else
      flash[:danger] = @user.errors.full_messages
      render 'new'
    end 
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end

