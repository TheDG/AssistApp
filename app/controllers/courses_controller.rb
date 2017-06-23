class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :all_qr, :export]
  before_action :authenticate_teacher!
  before_action :authenticate_admin!, except: [:own_index, :show]


  def export
    assistance = []
    aux = Assistance.all
    aux.each do |ass|
      assistance << ass if ass.course_id == @course.id
    end
    @dates = []
    assistance.each do |ass|
      aux = true
      @dates.each do |date|
        aux = false if date.strftime('%d-%m-%y') == ass.date.strftime('%d-%m-%y')
      end
      @dates << ass.date if aux
    end
    send_data @course.export(@dates),
              filename: "#{@course.grade}-#{@course.subject}-#{@course.level}-grades.csv"
  end

  def all_qr
    tmp_path = @course.zip_all_qr
    send_file tmp_path, type: 'application/zip',
              disposition: 'attachment',
              filename: "#{@course.grade}-#{@course.subject}-#{@course.level}.zip"
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  def own_index
    @courses = Course.where(teacher: current_teacher)
    render 'index'
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    assistance = []
    aux = Assistance.all
    aux.each do |ass|
      assistance << ass if ass.course_id == @course.id
    end
    @dates = []
    assistance.each do |ass|
      aux = true
      @dates.each do |date|
        aux = false if date.strftime('%d-%m-%y') == ass.date.strftime('%d-%m-%y')
      end
      @dates << ass.date if aux
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    @teachers = Teacher.all
  end

  # GET /courses/1/edit
  def edit
    @teachers = Teacher.all
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        @course.teacher = Teacher.where(email: params[:teacher]).first
        @course.save
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # TODO teacher_id is strange, hot fix tmb en course form
  def course_params
    params.require(:course).permit(:teacher, :subject, :grade, :level, :teacher_id)
  end
end
