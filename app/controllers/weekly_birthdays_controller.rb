class WeeklyBirthdaysController < ApplicationController
  # index
  #   Retrieves a list of people whose birthdays fall within the current calendar week
  # params
  #   date: overrides today's date to represent the current calendar week
  # outputs
  #   @date: today's date or the overriden date, if provided
  #   @people: an array of people
  def index
    @date = parse_date_param || Date.today
    retrieved_people = Person.all

    @people = []
    retrieved_people.each do |person|
      this_year_birthday = get_this_year_birthday(person.birthdate)
      @people.push(build_formatted_person(person, this_year_birthday)) if is_birthday_in_calendar_week(this_year_birthday)
    end

    @people.sort!{ |a, b| a[:birthday_day_of_week_index] <=> b[:birthday_day_of_week_index] }
  end

  private
    def build_formatted_person(person, this_year_birthday)
      this_year_birthday_day_of_week_index = this_year_birthday.wday
      {
        first_name: person.first_name,
        last_name: person.last_name,
        birthdate: person.birthdate,
        birthday_day_of_week: get_day_of_week(this_year_birthday_day_of_week_index),
        birthday_day_of_week_index: this_year_birthday_day_of_week_index,
        age: get_age(person.birthdate)
      }
    end

    def get_day_of_week(day_index)
      Date::DAYNAMES[day_index]
    end

    def get_this_year_birthday(birthdate)
      if (!@date.leap? && birthdate.month == 2 && birthdate.day == 29)
        Date.new(@date.year, 3, 1)
      else
        Date.new(@date.year, birthdate.month, birthdate.day)
      end
    end

    def get_age(birthdate)
      @date.year - birthdate.year
    end

    def parse_date_param
      Date.parse(params[:date]) if !params[:date].nil?
    end

    def is_birthday_in_calendar_week(birthdate)
      birthdate.cweek == @date.cweek
    end
end
