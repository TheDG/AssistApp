# course model
require 'zip'

class Course < ApplicationRecord
  has_and_belongs_to_many :students
  belongs_to :teacher
  has_many :assistances, through: :students

  def zip_all_qr
    tmp_path = Rails.root.join('tmp', "#{grade}-#{subject}-#{level}.zip")
    File.delete(tmp_path)
    Zip::File.open(tmp_path, Zip::File::CREATE) do |z|
      students.map.uniq.each do |stud|
        z.add("#{stud.rut}.png", stud.gen_qr[1])
      end
    end
    tmp_path
  end

end