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

Given(/^there is a person (.*?) with a birthday on (.*?)$/) do |name, birthdate|
  date = Date.parse(birthdate)
  create(:person, first_name: name, birthdate: date)
end

Given(/^there are the following people:$/) do |table|
  table.hashes.map do |row|
    date = Date.parse(row["Birthdate"])
    create(:person, first_name: row["Name"], birthdate: date)
  end
end

When(/^I get weekly birthdays$/) do
  get '/getWeeklyBirthdays', format: :json
end

When(/^I get weekly birthdays on (.*?)$/) do |birthdate|
  date = Date.parse(birthdate)
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

Then(/^there should be the following people with birthdays that week:$/) do |table|
  table.hashes.map do |row|
    order = row["Order"].to_i
    check_birthday_day_of_week(order, row["Day"])
    check_age(order, row["Age"].to_i)
  end
end
