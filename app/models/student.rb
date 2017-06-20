# student model
require 'csv'
class Student < ApplicationRecord
  has_many :assistances
  has_and_belongs_to_many :courses
  validates :rut, uniqueness: true

  def self.import(file)
    begin
      CSV.foreach(file.path, headers:true) do |row|
        Student.create! row.to_hash
      end
    rescue => error
      return error
    end
  end

  def self.export(options = {})
    attributes = %w{name last_name rut}
    @csv = CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |student|
        csv << student.attributes.values_at(*attributes)
      end
    end
    puts "CSV: "+ @csv
    return @csv
  end

end
