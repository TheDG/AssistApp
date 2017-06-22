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
            teahcer: @teacher.name}
    data = {
          yes: @yes,
          no: @no,
          dates: @dates,
          course: course_data}

      render json: data
  end


  def student
    student_id= params[:student]
    @teacher = current_teacher
    @student = Student.find(student_id);
    all =[]
    course_data= []

    @dates = []
    @student.assistances.each do |ass|
      @dates << ass.date unless @dates.include?(ass.date)
    end
    c_ids=[]
    @student.courses.each do |course|
      c_ids << course.id
      @assistance = []
      aux = Assistance.all
      aux.each do |ass|
        @assistance << ass if (ass.course_id == course.id && ass.student_id == @student.id)
      end
      @go = []
      @dates.each do |d|
        aux_count = 0
        @assistance.each do |ass|
          if (ass.date==d)
            aux_count = -1
            if (ass.attend)
              aux_count= 1
            end
          end
        end
        @go << aux_count
      end
      course_data << [course.subject+" "+course.grade+"-"+course.level,@teacher.name,@go,course.id]
      Rails.logger.debug("+++++++++ #{course_data[course.id].inspect} ")
    end
    student = {
            name:       @student.name,
            rut:        @student.rut,
            courses:    c_ids}
    data = {
          dates: @dates,
          courses: course_data,
          student: student}

    render json: data
  end


  def home; end
end
