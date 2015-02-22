module WeeklyBirthdaysHelper
  def get_day_of_week(day_index)
    Date::DAYNAMES[day_index]
  end
end
