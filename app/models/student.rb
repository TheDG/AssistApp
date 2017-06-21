# student model
require 'rqrcode'
require 'csv'
require 'open-uri'
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

  def gen_qr
    qrcode = RQRCode::QRCode.new(rut)
# With default options specified explicitly
    tmp_path = Rails.root.join('tmp', rut)
    png = qrcode.as_png(
        resize_gte_to: false,
        resize_exactly_to: false,
        fill: 'white',
        color: 'black',
        size: 120,
        border_modules: 4,
        module_px_size: 6,
        file: tmp_path # path to write
    )
    [png, tmp_path]
  end

end
