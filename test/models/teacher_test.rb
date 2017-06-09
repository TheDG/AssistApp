require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  test "unqiue_rut" do
    teacher = Teacher.new(rut: '123123123', email: 'ucs@uc.ck', password: '123123')
    assert_not teacher.save
  end

  test "unqiue_email" do
    teacher = Teacher.new(rut: '1231231231', email: 'dtest@uc.cl', password: '123123')
    assert_not teacher.save
  end
end
