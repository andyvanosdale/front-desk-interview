module WeeklyBirthdaysHelper
  @@DAYNAMES = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  def get_day_of_week(day_index)
    t(@@DAYNAMES[day_index])
  end
end
