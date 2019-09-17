class EntriesController < ApplicationController
  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.activity_id.blank?
      activity = current_user.activities.create(name: params[:activity_name], category: params[:activity_category])
      @entry.activity_id = activity.id
    end
    if @entry.save
      redirect_to dashboard_path
    else
      flash[:danger] = @entry.errors.full_messages
      redirect_to dashboard_path
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:minutes, :activity_id)
  end
end

