class Student < ApplicationRecord
  has_many :assistances
  has_and_belongs_to_many :courses
end
