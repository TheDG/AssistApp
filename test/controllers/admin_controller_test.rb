require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:diego)
    sign_in(@teacher)
  end

  test "should get display" do
    get admin_display_path
    assert_response :success
  end

  test "should get all enrolled" do
    get admin_student_courses_index_path
    assert_response :success
  end

  test "should enroll student" do
    @course = courses(:science)
    assert_difference('@course.students.count') do
      post admin_add_student3_path, params: { student: students(:juan).rut, course: @course.id }
    end
  end

end
