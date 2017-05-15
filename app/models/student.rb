class Student < ApplicationRecord
  has_many :asistences
  has_many :course
end
