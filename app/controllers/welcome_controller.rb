class WelcomeController < ApplicationController
  def index
    @teacher = Teacher.first
    @allteachers = Teacher.all
  end
end
