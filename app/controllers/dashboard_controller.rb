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
    @past_week_chartkick_data = past_week_chartkick_data
    @past_month_chartkick_data = past_month_chartkick_data
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

  def past_week_data
    current_user.entries.joins(:activity).where('entries.created_at >=?', 7.days.ago.beginning_of_day).group('activities.category', 'entries.created_at::date').sum(:minutes)
  end

  def past_week_contributor_data
    data = past_week_data
      .select { |entry_key| entry_key[0] == "contributor" }
      .inject({}) do |obj, (key, value)|
        obj[key[1]] = value
        obj
      end

    (7.days.ago.to_date..Date.today).each do |date|
      data[date] ||= 0
      data[date] += (data[date-1.day] || 0)
    end
    data
  end
  
  def past_week_subtractor_data
    data = past_week_data
      .select { |entry_key| entry_key[0] == "subtractor" }
      .inject({}) do |obj, (key, value)|
        obj[key[1]] = value
        obj
      end

    (7.days.ago.to_date..Date.today).each do |date|
      data[date] ||= 0
      data[date] += (data[date-1.day] || 0)
    end
    data
  end

  def past_week_chartkick_data
    [
      {
	name: 'Contributors',
	data: past_week_contributor_data
      },
      {
	name: 'Subtractors',
	data: past_week_subtractor_data
      }
    ] 
  end

  def past_month_data
    current_user.entries.joins(:activity).where('entries.created_at >=?', 30.days.ago.beginning_of_day).group('activities.category', 'entries.created_at::date').sum(:minutes)
  end

  def past_month_contributor_data
    data = past_month_data
      .select { |entry_key| entry_key[0] == "contributor" }
      .inject({}) do |obj, (key, value)|
        obj[key[1]] = value
        obj
      end

    (30.days.ago.to_date..Date.today).each do |date|
      data[date] ||= 0
      data[date] += (data[date-1.day] || 0)
    end
    data
  end
  
  def past_month_subtractor_data
    data = past_month_data
      .select { |entry_key| entry_key[0] == "subtractor" }
      .inject({}) do |obj, (key, value)|
        obj[key[1]] = value
        obj
      end

    (30.days.ago.to_date..Date.today).each do |date|
      data[date] ||= 0
      data[date] += (data[date-1.day] || 0)
    end
    data
  end

  def past_month_chartkick_data
    [
      {
	name: 'Contributors',
	data: past_month_contributor_data
      },
      {
	name: 'Subtractors',
	data: past_month_subtractor_data
      }
    ] 
  end
end

