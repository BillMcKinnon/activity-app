class DashboardController < ApplicationController
  def show 
    @activities = current_user.activities
    @entry_balance = find_entry_balance
    @entry_rounded_hour = convert_to_rounded_hour
    @entries = current_user.entries
    @entry = Entry.new
  end

  private 
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

