class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :generate_qr]
  before_action :authenticate_teacher!
  before_action :authenticate_admin!, except: [:own_index, :show]


  def generate_qr
    tuple = @student.gen_qr
    send_data tuple[0], type: 'image/png', filename: @student.rut
    File.delete(tuple[1])
    #render json: nil, status: :ok
  end

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    respond_to do |format|
      format.html
      format.csv { send_data @students.export }
    end
  end

  def own_index
    aux = Student.all
    @students = []
    aux.each do |student|
      student.courses.each do |course|
        @students << student if course.teacher == current_teacher
      end
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show; end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit; end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    @import = ""
    begin
      @import = Student.import(params[:file])

      if @import == true
        redirect_to students_url notice: "Activity Data Imported"
      else
        redirect_to students_url notice: @import.to_s
      end
    rescue => error
      flash.now[:alert] = error
      redirect_to student_url notice: error.to_s
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name, :last_name, :rut)
  end
end
