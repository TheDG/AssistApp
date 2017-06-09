require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:diego)
    sign_in(@teacher)
    @auth_head = @teacher.create_new_auth_token
  end

  test "destroy all assistance" do
    delete '/api/v1/all_assistance', params: {}, headers: @auth_head
    assert_response :success
    assert_equal(0, Assistance.count)
  end

  test "destroy assistance" do
    assert_difference('Assistance.count', -1) do
      delete '/api/v1/assistance', params: {date: '2017-12-2', rut: students(:pete).rut},
             headers: @auth_head
      assert_response :success
    end
  end

  test "destroy assistance 2 courses" do
    assert_difference('Assistance.count', -2) do
      delete '/api/v1/assistance', params: {date: '2017-12-4', rut: students(:pete).rut},
             headers: @auth_head
      assert_response :success
    end
  end

  test "check correct courses #" do
    get '/api/v1/course_students', params: {},
        headers: @auth_head
    assert_response :success
    assert_equal(assigns(:aux).as_json.count, 2)
  end

  test "check correct courses owner" do
    get '/api/v1/course_students', params: {},
        headers: @auth_head
    assert_response :success
    assigns(:aux).as_json.each do | course |
      assert_equal(course['teacher_id'], @teacher.id)
    end
  end

  test "check correct students in course owner" do
    get '/api/v1/course_students', params: {},
        headers: @auth_head
    assert_response :success
    assigns(:aux).as_json.each do | course |
      course_aux = Course.find(course['id'])
      course['students'].each do |stud|
        if course_aux.students.include?(Student.where(id: stud['id']).first)
          assert true
        else
          assert false
        end
      end
    end
  end

  test "correct record assistance" do
    course = courses(:english)
    assert_difference('course.assistances.count', 1) do
      post '/api/v1/record_assistance', params: {date: '2018-12-4', rut: students(:pete).rut, course_id: course.id},
           headers: @auth_head
      assert_response :success
    end
    assert_difference('students(:pete).assistances.count', 1) do
      post '/api/v1/record_assistance', params: {date: '2018-12-4', rut: students(:pete).rut, course_id: course.id},
           headers: @auth_head
      assert_equal(course.id,Assistance.last.course_id)
    end
  end

end
