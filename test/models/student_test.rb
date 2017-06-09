require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "unqiue_rut" do
    student = Student.new(rut: '111111')
    assert_not student.save
  end

end
