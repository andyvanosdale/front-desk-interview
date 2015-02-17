World(Rack::Test::Methods)

Given(/^there are no people$/) do
end

When(/^I get weekly birthdays$/) do
  get '/getWeeklyBirthdays', format: :json
end

Then(/^there should be no birthdays$/) do
  assert_equal 200, last_response.status
  json = JSON.parse(last_response.body)
  assert json.kind_of?(Array)
  assert_equal 0, json.count
end