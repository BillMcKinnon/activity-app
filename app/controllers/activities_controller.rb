class ActivitiesController < ApplicationController
  include SessionsHelper

  def index
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash.now[:success] = "Activity saved."
      redirect_to activities_path
    else
      flash.now[:danger] = "There are errors."
      render 'new'
    end
  end

  def show
    
  end

  def destroy
  end


  private
    def activity_params
      params.require(:activity).permit(:name, :category, :minutes)
    end 
end
