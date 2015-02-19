FactoryGirl.define do
  factory :person do
    first_name "John"
    last_name "Doe"
    birthdate Date.today
  end
end