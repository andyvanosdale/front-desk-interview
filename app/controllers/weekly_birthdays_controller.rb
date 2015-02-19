class WeeklyBirthdaysController < ApplicationController
  # index
  # Retrieves a list of people whose birthdays fall within the current calendar week
  # params
  #   date: overrides today's date to represent the current calendar week
  def index
    @date = parse_date_param || Date.today
    retrieved_people = Person.all

    @people = []
    for person in retrieved_people
      @people.push(build_formatted_person(person)) if is_birthday_in_calendar_week(person.birthdate)
    end

    @people.sort!{ |a, b| a[:birthday_day_of_week_index] <=> b[:birthday_day_of_week_index] }
  end

  private
    def build_formatted_person(person)
      birthday_day_of_week_index = get_birthday_day_of_week_index(person.birthdate)
      {
        first_name: person.first_name,
        last_name: person.last_name,
        birthdate: person.birthdate,
        birthday_day_of_week: get_birthday_day_of_week(birthday_day_of_week_index),
        birthday_day_of_week_index: birthday_day_of_week_index,
        age: get_age(person.birthdate),
      }
    end

    def get_birthday_day_of_week(birthday_day_of_week_index)
      Date::DAYNAMES[birthday_day_of_week_index]
    end

    def get_birthday_day_of_week_index(birthdate)
      Date.new(@date.year, birthdate.month, birthdate.day).wday
    end

    def get_age(birthdate)
      @date.year - birthdate.year
    end

    def parse_date_param
      Date.parse(params[:date]) if !params[:date].nil?
    end

    def is_birthday_in_calendar_week(birthdate)
      this_year_birthday = Date.new(@date.year, birthdate.month, birthdate.day)
      this_year_birthday.cweek == @date.cweek
    end
end
