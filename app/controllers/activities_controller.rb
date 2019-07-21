class ActivitiesController < ApplicationController
  include SessionsHelper

  def index
    @activities = current_user.activities
    @activity_balance = find_activity_balance.to_i
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash[:success] = "Activity saved."
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

    def find_activity_balance
      contributor_sum = current_user.activities.where("category = 'contributor'").sum(:minutes)
      subtractor_sum = current_user.activities.where("category = 'subtractor'").sum(:minutes)
      contributor_sum - subtractor_sum
    end
end
