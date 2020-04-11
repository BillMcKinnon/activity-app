class DashboardController < ApplicationController
  include DataHelper

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

  def past_week_chartkick_data
    [
      {
	name: 'Contributors',
	data: past_data("contributor", 7)
      },
      {
	name: 'Subtractors',
	data: past_data("subtractor", 7)
      }
    ] 
  end
  
  def past_month_chartkick_data
    [
      {
	name: 'Contributors',
	data: past_data("contributor", 30)
      },
      {
	name: 'Subtractors',
	data: past_data("subtractor", 30)
      }
    ] 
  end
end

