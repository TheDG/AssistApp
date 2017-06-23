# course model
require 'zip'

class Course < ApplicationRecord
  has_and_belongs_to_many :students
  belongs_to :teacher
  has_many :assistances, through: :students

  def zip_all_qr
    tmp_path = Rails.root.join('tmp', "#{grade}-#{subject}-#{level}.zip")
    File.delete(tmp_path) if File.exist?(tmp_path)
    Zip::File.open(tmp_path, Zip::File::CREATE) do |z|
      students.map.uniq.each do |stud|
        z.add("#{stud.rut}.png", stud.gen_qr[1])
      end
    end
    tmp_path
  end

  def export(dates)
    attributes = %w{name last_name rut}
    dates = dates.sort_by {|date| date}
    dates.each do |date|
      attributes << date.strftime('%d-%m-%y')
    end
    @csv = CSV.generate(headers: true) do |csv|
      csv << attributes
      students.each do |student|
        aux_array = []
        aux_array << student.name
        aux_array << student.last_name
        aux_array << student.rut
        dates.each do |date|
          aux = false
          student.assistances.where(course_id: id).sort_by{|e| e[:date]}.each do |assistance|
            if assistance.date.strftime('%m-%d') == date.strftime('%m-%d')
              if assistance.attend
                aux = true
              end
            end
          end
          if aux
            aux_array << 'atendio'
          else
            aux_array << 'ausente'
          end
        end
        csv << aux_array
      end
      @csv
    end
  end

end
