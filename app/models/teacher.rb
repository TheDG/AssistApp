# Tacher model
class Teacher < ApplicationRecord
  has_many :courses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable # ,:confirmable
  validates :email, uniqueness: true
  validates :rut, uniqueness: true

  include DeviseTokenAuth::Concerns::User
end
