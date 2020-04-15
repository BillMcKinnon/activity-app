class ActivitiesController < ApplicationController
  include DataHelper

  def show
    @activity = current_user.activities.find(params[:id])
    @past_week_activity_data = past_week_activity_data
    @past_mont_activity_data = past_month_activity_data
  end

  private

  def past_week_activity_data
    [
      {
        name: @activity.name.titleize,
        data: past_data(@activity.name, "activities.name", 7)
      }
    ] 
  end

  def past_month_activity_data
    [
      {
        name: @activity.name.titleize,
        data: past_data(@activity.name, "activities.name", 30)
      }
    ] 
  end
end

