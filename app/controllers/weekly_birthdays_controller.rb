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
      @people.push(build_extended_person(person)) if is_birthday_in_calendar_week(person.birthdate)
    end
  end

  private
    def build_extended_person(person)
      {
        first_name: person.first_name,
        last_name: person.last_name,
        birthdate: person.birthdate,
        birthday_day_of_week: get_birthday_day_of_week(person.birthdate),
        age: get_age(person.birthdate)
      }
    end

    def get_birthday_day_of_week(birthdate)
      birthday_this_year = Date.new(@date.year, birthdate.month, birthdate.day)
      Date::DAYNAMES[birthday_this_year.wday]
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
