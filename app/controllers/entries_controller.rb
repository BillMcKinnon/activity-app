class EntriesController < ApplicationController
  include SessionsHelper

  def index
    @activities = current_user.activities
    @entry_balance = find_entry_balance
    @entry_rounded_hour = convert_to_rounded_hour
    @entries = current_user.entries
  end

  def new
    @entry = Entry.new
    @activities = current_user.activities
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.activity_id.blank?
      activity = current_user.activities.create(name: params[:activity_name], category: params[:activity_category])
      @entry.activity_id = activity.id
    end
    if @entry.save
      flash[:success] = "Entry saved."
      redirect_to entries_path
    else
      flash[:danger] = @entry.errors.full_messages
      render 'new'
    end
  end

  def show
    
  end

  def destroy

  end

  private

  def entry_params
    params.require(:entry).permit(:minutes, :activity_id)
  end

  def find_entry_balance
    contributor_sum = current_user.entries.joins(:activity).where(activities: { category: 'contributor' }).sum(:minutes)
    subtractor_sum = current_user.entries.joins(:activity).where(activities: { category: 'subtractor' }).sum(:minutes)
    contributor_sum - subtractor_sum
  end
  
  def convert_to_rounded_hour
    rounded_hour = @entry_balance / 60
    rounded_hour.round(1)
  end
end
