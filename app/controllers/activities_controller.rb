class ActivitiesController < ApplicationController
  def show
    @activity = current_user.activities.find(params[:id])
  end
end
