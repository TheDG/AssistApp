require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:pete)
    @teacher = teachers(:jm)
    @admin = teachers(:diego)
  end

  test "admin should get index" do
    sign_in(@admin)
    get students_url
    assert_response :success
  end

  test "teacher should not get index" do
    sign_in(@teacher)
    get students_url
    assert_response :unauthorized
  end

  test "admin should get new" do
    sign_in(@admin)
    get new_student_url
    assert_response :success
  end

  test "teacher should not get new" do
    sign_in(@teacher)
    get new_student_url
    assert_response :unauthorized
  end

  test "should create student" do
    sign_in(@admin)
    assert_difference('Student.count') do
      post students_url, params: { student: { last_name: @student.last_name, name: @student.name, rut: '987987' } }
    end
    assert_redirected_to student_url(Student.last)
  end

  test "teacher should not create student" do
    sign_in(@teacher)
    assert_no_difference('Student.count') do
      post students_url, params: { student: { last_name: @student.last_name, name: @student.name, rut: '987987' } }
    end
  end

  test "should not create student" do
    assert_no_difference('Teacher.count',
                         message = 'Cant create student with same rut') do
      post students_url, params: { student: { last_name: @student.last_name, name: @student.name, rut: @student.rut } }
    end
  end

  test "should show student" do
    sign_in(@teacher)
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@admin)
    get edit_student_url(@student)
    assert_response :success
  end

  test "teacher should not get edit" do
    sign_in(@teacher)
    get edit_student_url(@student)
    assert_response :unauthorized
  end
  test "should update student" do
    sign_in(@admin)
    patch student_url(@student), params: { student: { last_name: @student.last_name, name: @student.name } }
    assert_redirected_to student_url(@student)
  end

  test "admin should destroy student" do
    sign_in(@admin)
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end
    assert_redirected_to students_url
  end

  test "teacher should not destroy student" do
    sign_in(@teacher)
    assert_difference('Student.count', 0) do
      delete student_url(@student)
    end
  end
end
