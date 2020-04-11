class EntriesController < ApplicationController
  def create
    entry = current_user.entries.build(entry_params)
    
    ActiveRecord::Base.transaction do
      if entry.activity_id.blank?
        if current_user.activities.exists?(name: params[:activity_name].downcase.strip) 
          entry.activity_id = current_user.activities.find_by(name: params[:activity_name].downcase.strip).id
        else 
          activity = current_user.activities.create(name: params[:activity_name].strip, category: params[:activity_category])
          entry.activity_id = activity.id
        end
      end

      if entry.save
        flash[:success] = "Entry saved!"
      else
        flash[:danger] = entry.errors.full_messages
        raise ActiveRecord::Rollback
      end
    end

    redirect_to dashboard_path
  end

  def edit
    @entry = current_user.entries.find(params[:id])
    @activity = @entry.activity
  end

  def update
    entry = current_user.entries.find(params[:id])
    activity = current_user.activities.find_by(name: params[:activity_name].downcase.strip)

    if activity.blank?
      activity = current_user.activities.create(name: params[:activity_name].strip, category: params[:activity_category])
    elsif params[:activity_category] != activity.category
      activity.update(category: params[:activity_category])
    end

    if entry.update(entry_params.merge(activity_id: activity.id))
      flash[:success] = "Entry edited successfully."
      redirect_to activity_path(activity.id)
    else
      flash[:danger] = entry.errors.full_messages
      redirect_to activity_path(activity.id)
    end
  end

  def destroy
    entry = current_user.entries.find(params[:id])
    activity = entry.activity

    if entry.destroy
      activity.destroy if activity.entries.count == 0
      flash[:success] = "Entry deleted."
      redirect_to dashboard_path
    else
      flash[:danger] = "Entry not deleted. Contact support to resolve this issue."
      redirect_to dashboard_path
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:minutes, :activity_id)
  end
end

