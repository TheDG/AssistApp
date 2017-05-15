class Student < ApplicationRecord
  has_many :assistances
  has_many :courses
end
