# Represents a person with a birthdate
class Person < ActiveRecord::Base
  include Birthdateable
end
