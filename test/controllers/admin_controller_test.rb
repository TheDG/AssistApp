require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:jm)
    @admin = teachers(:diego)
  end

  test "should get display" do
    sign_in(@admin)
    get admin_display_path
    assert_response :success
  end

  test "should get all enrolled" do
    sign_in(@admin)
    get admin_student_courses_index_path
    assert_response :success
  end

  test "should enroll student" do
    sign_in(@admin)
    @course = courses(:science)
    assert_difference('@course.students.count') do
      post admin_add_student3_path, params: { student: students(:juan).rut, course: @course.id }
    end
  end

  test "teacher should not get display" do
    sign_in(@teacher)
    get admin_display_path
    assert_response :unauthorized
  end

  test "teacher should not get all enrolled" do
    sign_in(@teacher)
    get admin_student_courses_index_path
    assert_response :unauthorized
  end

  test "teacher should not enroll student" do
    sign_in(@teacher)
    @course = courses(:science)
    assert_no_difference('@course.students.count') do
      post admin_add_student3_path, params: { student: students(:juan).rut, course: @course.id }
    end
  end
end
