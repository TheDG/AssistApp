class WelcomeController < ApplicationController
  before_action :authenticate_teacher!, except: [:home]
  def index
    @teacher = current_teacher
    @allteachers = Teacher.all
  end

  def home; end
end
