class DashboardController < ApplicationController
  def show 
    @entry_balance = find_entry_balance
    @entries = current_user.entries
    @entry = Entry.new
    @activities = current_user.activities
    @contributors = current_user.activities.where({ category: 'contributor' }).order(:name)
    @subtractors = current_user.activities.where({ category: 'subtractor' }).order(:name)
    @contributor_sum = find_contributor_sum
    @subtractor_sum = find_subtractor_sum
  end

  private 
  def mins_to_condensed_time(mins)
    if mins  >= 60
      hours = (mins / 60).floor
      mins_left = mins - (60 * hours)
      time_string = "#{hours}h"
      time_string += "#{mins_left}m" if mins_left > 0
      time_string
    else
      "#{mins}m"
    end
  end
  helper_method :mins_to_condensed_time

  def find_contributor_sum
    current_user.entries.joins(:activity).where(activities: { category: 'contributor' }).sum(:minutes)
  end

  def find_subtractor_sum
    current_user.entries.joins(:activity).where(activities: { category: 'subtractor' }).sum(:minutes)
  end

  def find_entry_balance
    contributor_sum = current_user.entries.joins(:activity).where(activities: { category: 'contributor' }).sum(:minutes)
    subtractor_sum = current_user.entries.joins(:activity).where(activities: { category: 'subtractor' }).sum(:minutes)
    contributor_sum - subtractor_sum
  end
end

