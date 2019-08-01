class EntriesController < ApplicationController
  include SessionsHelper

  def index
    @activities = current_user.activities
    @activity_balance = find_activity_balance
    @activity_rounded_hour = convert_to_rounded_hour
  end

  def new
    @entry = Entry.new
  end

  def create
    Entry.create(
      activity: activity,
      *entry_params
    )
  end

  def show
    
  end

  def destroy
  end


  private
    def activity
      if params[:entry][:activity_name].present?
        Activity.create(name: params[:entry][:activity_name], categpry: params[:entry][:activity_category])
      end
    end

    def entry_params
      params.require(:entry).permit(:activity_id, :minutes)
    end
  #  def activity_params
  #    params.require(:activity).permit(:name, :category, :minutes)
  #  end

  #  def find_activity_balance
  #    contributor_sum = current_user.activities.where(category: 'contributor').sum(:minutes)
  #    subtractor_sum = current_user.activities.where(category: 'subtractor').sum(:minutes)
  #    contributor_sum - subtractor_sum
  #  end
  #  
  #  def convert_to_rounded_hour
  #    rounded_hour = @activity_balance / 60
  #    rounded_hour.round(1)
  #  end
end
