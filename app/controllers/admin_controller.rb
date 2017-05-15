class AdminController < ApplicationController
  def display
  end

  def add_teacher
    @courses = Course.all
  end

  def add_student
    @courses = Course.all
  end

  def add_student2
    @course =  Course.find(params[:course])
  end

  def add_student3
    Course.find(params[:course]).students <<  Student.where(rut: params[:student])
    @courses = Course.all
    render 'admin/add_student'
  end

  def student_courses_index
    @courses = Course.all
  end


end
