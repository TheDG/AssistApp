# Teacher model
require 'csv'
class Teacher < ApplicationRecord
  has_many :courses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable # ,:confirmable, :registerable
  validates :email, uniqueness: true
  validates :rut, uniqueness: true
  include DeviseTokenAuth::Concerns::User

  def self.import(file)
    begin
      CSV.foreach(file.path, headers:true) do |row|
        puts row
        Teacher.create! row.to_hash
      end
    rescue => error
      return error
    end
  end

  def self.export(options = {})
    attributes = %w{name last_name rut email}
    @csv = CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |teacher|
        csv << teacher.attributes.values_at(*attributes)
      end
    end
    puts "CSV: "+ @csv
    return @csv
  end

end
