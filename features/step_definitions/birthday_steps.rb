World(FactoryGirl::Syntax::Methods)

module BirthdayStepsHelper
  def response_status_is(status)
    assert_equal status, last_response.status
  end

  def response_basic_checks
    response_status_is(200)
    @json = JSON.parse(last_response.body)
    assert @json.kind_of?(Array)
  end

  def response_count(count)
    assert_equal count, @json.count
  end

  def check_birthday_day_of_week(index, day_of_week)
    assert_equal day_of_week, @json[index-1]['birthday_day_of_week']
  end

  def check_age(index, age)
    assert_equal age, @json[index-1]['age']
  end
end
World(BirthdayStepsHelper)

Given(/^there are no people$/) do
end

Given(/^there is a person with a birthday on (\d+)\-(\d+)\-(\d+)$/) do |year, month, day|
  date = Date.new(year.to_i, month.to_i, day.to_i)
  create(:person, birthdate: date)
end

When(/^I get weekly birthdays$/) do
  get '/getWeeklyBirthdays', format: :json
end

When(/^I get weekly birthdays on (\d+)\-(\d+)\-(\d+)$/) do |year, month, day|
  date = Date.new(year.to_i, month.to_i, day.to_i)
  get '/getWeeklyBirthdays', date: date, format: :json
end

Then(/^there should be (\d+) birthdays*$/) do |count|
  response_basic_checks
  response_count(count.to_i)
end

Then(/^the (\d+)(?:st|nd|rd|th) person's birthday day should be on (.*?)$/) do |index, day|
  check_birthday_day_of_week(index.to_i, day)
end

Then(/^the (\d+)(?:st|nd|rd|th) person's age should be (\d+)$/) do |index, age|
  check_age(index.to_i, age.to_i)
end
