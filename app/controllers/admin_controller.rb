class AdminController < ApplicationController
  before_action :authenticate_teacher!
  before_action :authenticate_admin!

  def display; end

  def add_teacher
    @courses = Course.all
  end

  def add_student
    @courses = Course.all
  end

  def add_student2
    @course =  Course.find(params[:course])
    @current_students = @course.students
    @possible_students = Student.all.to_a
    @current_students.each do |actual|
      @possible_students.delete(actual)
    end
  end

  def add_student3
    Course.find(params[:course]).students << Student.where(rut: params[:student])
    @courses = Course.all
    render 'admin/add_student'
  end

  def student_courses_index
    @courses = Course.all
  end
end
