require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:diego)
  end

  test "should get index" do
    sign_in(@teacher)
    get teachers_url
    assert_response :success
  end

  test "should get new" do
    sign_in(@teacher)
    get new_teacher_path
    assert_response :success
  end

  test "should create teacher" do
    assert_difference('Teacher.count') do
      Teacher.create(email: 'uc@uc.cl', rut: '123321', password: '123321')
    end
  end

  test "should not create teacher" do
    assert_no_difference('Teacher.count',
                         message = 'Cant create teacher with same rut') do
      Teacher.create(email: 'uc@uc.cl', rut: @teacher.rut, password: '123321')
    end
  end

  test "should show teacher" do
    sign_in(@teacher)
    get teacher_url(@teacher)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@teacher)
    get edit_teacher_url(@teacher)
    assert_response :success
  end

  test "should update teacher" do
    sign_in(@teacher)
    patch teacher_url(@teacher), params: { teacher: { email: @teacher.email, last_name: @teacher.last_name, name: @teacher.name } }
    assert_redirected_to teacher_url(@teacher)
  end

  test "should destroy teacher" do
    sign_in(@teacher)
    assert_difference('Teacher.count', -1) do
      delete teacher_url(@teacher)
    end
    assert_redirected_to teachers_url
  end

  test "should show own students" do
    sign_in(@teacher)
    get own_index_students_path(@teacher)
    assert_response :success
  end

  test "should show own courses" do
    sign_in(@teacher)
    get own_index_courses_path(@teacher)
    assert_response :success
    assigns(:courses).each do |course|
      assert_equal course.teacher, @teacher
    end
  end
end
