module DataHelper 
  def past_data(activity_attribute, grouped_by = "activities.category", number_of_days)
    data = current_user.entries
      .joins(:activity)
      .where('entries.created_at >=?', number_of_days.days.ago.beginning_of_day)
      .group(grouped_by, 'entries.created_at::date')
      .sum(:minutes)
      .select { |entry_key| entry_key[0] == activity_attribute }
      .inject({}) do |obj, (key, value)|
        obj[key[1]] = value
        obj
      end

    (number_of_days.days.ago.to_date..Date.today).each do |date|
      data[date] ||= 0
      data[date] += (data[date-1.day] || 0)
    end
    data
  end
end
