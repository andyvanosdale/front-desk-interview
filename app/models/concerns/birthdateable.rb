# Extends an object to include birthday specific operations
module Birthdateable
  extend ActiveSupport::Concern

  # Gets the current date, or the overriden date if provided
  def current_date
    if @date
      @date
    else
      @date = Date.today
    end
  end

  # Overrides the current date for certain operations requiring the current date
  def current_date=(value)
    @date = value
  end

  # Gets the age
  def age
    current_date.year - birthdate.year
  end

  # Gets the current birthday
  def current_birthdate
    if @current_birthdate.nil?
      if (!current_date.leap? && birthdate.month == 2 && birthdate.day == 29)
        @current_birthdate = Date.new(current_date.year, 3, 1)
      else
        @current_birthdate = Date.new(current_date.year, birthdate.month, birthdate.day)
      end
    end
    @current_birthdate
  end

  # Gets the current birthdate's week day index
  def current_birthdate_wday
    current_birthdate.wday
  end

  # Gets whether the birthday is in the current calendar week
  def is_birthdate_in_calendar_week
    current_birthdate.cweek == current_date.cweek
  end
end