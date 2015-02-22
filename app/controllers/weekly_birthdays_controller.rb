# Handles weekly birthdays for a collection of people
class WeeklyBirthdaysController < ApplicationController
  # index
  #   Retrieves a list of people whose birthdays fall within the current calendar week
  # params
  #   date: overrides today's date to represent the current calendar week
  # outputs
  #   @date: today's date or the overriden date, if provided
  #   @people: an array of people
  def index
    current_date = parse_date_param || Date.today
    retrieved_people = Person.all

    @people = []
    ActiveSupport::Notifications.instrument "people.filter" do
      retrieved_people.each do |person|
        person.current_date = current_date
        @people.push(person) if person.is_birthdate_in_calendar_week
      end
    end

    ActiveSupport::Notifications.instrument "people.sort" do
      @people.sort!{ |left, right| left.current_birthdate_wday <=> right.current_birthdate_wday }
    end
  end

  private
    def parse_date_param
      Date.parse(params[:date]) if !params[:date].nil?
    end
end
