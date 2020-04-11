module ApplicationHelper
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
end
