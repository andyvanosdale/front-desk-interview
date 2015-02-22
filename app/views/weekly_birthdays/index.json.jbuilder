json.array! @people do |person|
  json.first_name person.first_name
  json.last_name person.last_name
  json.birthdate person.birthdate
  json.age person.age
  json.birthday_day_of_week get_day_of_week(person.current_birthdate_wday)
end