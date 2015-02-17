Rails.application.routes.draw do
  get 'getWeeklyBirthdays' => 'weekly_birthdays#index'
end
