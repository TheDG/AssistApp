class Course < ApplicationRecord
  has_many :stundets
  belongs_to :teacher
end
