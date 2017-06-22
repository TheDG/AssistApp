class WelcomeController < ApplicationController
  before_action :authenticate_teacher!, except: [:home]
  def index
    @teacher = current_teacher
    @allteachers = Teacher.all
    @course = Course.first
  end

  def metrics
    @teacher = current_teacher
    @allteachers = Teacher.all
    @course = @teacher.courses.first

    @assistance = []
    aux = Assistance.all
    aux.each do |ass|
      @assistance << ass if ass.course_id == @course.id
    end
    @dates = []
    @assistance.each do |ass|
      @dates << ass.date unless @dates.include?(ass.date)
    end
    @yes = []
    @no = []
    count= @course.students.length
    @dates.each do |d|
      aux_count = 0
      @assistance.each do |ass|
        if ((ass.date=d) && (ass.attend))
          aux_count= aux_count+1
        end
      end
      @yes << aux_count
      @no  << count - aux_count
    end
  end


      def data
        course_id= params[:course]

        @teacher = current_teacher
        @allteachers = Teacher.all
        @course = Course.find(course_id);

        @assistance = []
        aux = Assistance.all
        aux.each do |ass|
          @assistance << ass if ass.course_id == @course.id
        end
        @dates = []
        @assistance.each do |ass|
          @dates << ass.date unless @dates.include?(ass.date)
        end
        @yes = []
        @no = []
        count= @course.students.length
        @dates.each do |d|
          aux_count = 0
          Rails.logger.debug("+++++++++ #{d.inspect} ")
          @assistance.each do |ass|
            if ((ass.date==d) && (ass.attend))
              aux_count= aux_count+1
            end
          end
          @yes << aux_count
          @no  << @course.students.length - aux_count
        end
        course_data = {
                  name:  @course.subject+" "+@course.grade+"-"+@course.level,
                  teahcer: @teacher.name
              }

        data = {
              yes: @yes,
              no: @no,
              dates: @dates,
              course: course_data
          }

          render json: data
      end

  def home; end
end
